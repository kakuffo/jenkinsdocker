#!/usr/bin/env python3
import argparse
import json
import sys

import requests


def init_argparse():
    parser = argparse.ArgumentParser(usage="funlux",
                                     description="Send a MS Teams message card to a incoming webhook with details of a Jenkins build")
    parser.add_argument("-w", "--webhook-url", help="JQTODO - missing")
    parser.add_argument("-b", "--branch-name", help="JQTODO - missing")
    parser.add_argument("-u", "--build-url", help="JQTODO - missing")
    parser.add_argument("-s", "--status", help="JQTODO - missing")
    parser.add_argument("-i", "--status-image", help="JQTODO - missing")
  #  parser.add_argument("-c", "--changes-file", help="JQTODO - missing")

    return parser


def validate_args(args):
    return True


def get_message_template():
    return load_json("message-template.json")


def load_json(file_path):
    with open(file_path) as file:
        return json.load(file)


def populate_message(args, payload):
    payload["sections"][0]["activityImage"] = args.status_image
    payload["sections"][0]["activitySubtitle"] = "of branch {}".format(args.branch_name)
    payload["sections"][0]["facts"][0]["value"] = args.status
    payload["sections"][0]["facts"][1]["value"] = "[View]({}console)".format(args.build_url)
    return populate_message_with_changes(args.changes_file, payload)


def populate_message_with_changes(changes_file, payload):
    changes = load_json(changes_file)
    listAsString = ""
    for commit in changes:
        listAsString += "#{}\rby **{}** (*{}*)\r".format(commit["msg"], commit["author"], commit["id"])

        if (len(commit["files"]) > 0):
            listAsString += "\r"
            for file in commit["files"]:
                listAsString += "  *{}*   {}\r\r".format(file["editType"], file["path"])
            listAsString += "\r"

    payload["sections"][1]["text"] = listAsString

    return payload


def format_as_list(items):
    retVal = ""
    for item in items:
        retVal += "- " + item + "\r"
    return retVal


def main():
    parser = init_argparse()
    args = parser.parse_args()

    if (not validate_args(args)):
        print("Missing or invalid arguments!")
        return

    payload = populate_message(args, get_message_template())

    result = requests.post(url=args.webhook_url, json=payload)
    print(result)


main()
