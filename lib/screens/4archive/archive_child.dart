import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:memoapp/model/archive.dart';
import 'archive_edit.dart';

class ChildArchive extends StatelessWidget {
  final Archive archive;

  ChildArchive(this.archive);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArchiveEditScreen(
              archiveId: archive.id,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 0.7,
            color: Colors.red.withOpacity(0.8),
          ),
          //borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 26.0,
        ),
        width: size.width * 0.8,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Text(
                archive.content,
                style: const TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('yyyy. MM. dd')
                      .format(archive.creationTime.toDate()),
                  style: const TextStyle(fontSize: 10.0),
                ),
                const SizedBox(width: 30),
                archive.sayer == ""
                    ? const Spacer()
                    : Flexible(
                        child: Text(
                          "- " + archive.sayer!,
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
