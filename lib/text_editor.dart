import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:provider/provider.dart';

import 'state_management.dart';
import 'text_field.dart';
import 'toolbar.dart';

class TextEditor extends StatefulWidget {
  TextEditor({Key key}) : super(key: key);

  @override
  _TextEditorState createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
bool showToolbar = false;

@override
void initState() { 
  super.initState();
  KeyboardVisibilityNotification().addNewListener(
    onChange: (isVisible) {
      if (!isVisible) {
        FocusScope.of(context).unfocus();
      }
      setState(() {
        showToolbar = isVisible;
      });
    },
  );
}

@override
void dispose() { 
  KeyboardVisibilityNotification().dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditorProvider>(
      create: (context) => EditorProvider(),
      builder: (context, child) {
        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: <Widget>[
                Positioned(
                  top: 16,
                  left: 0,
                  right: 0,
                  bottom: 56,
                  child: Consumer<EditorProvider>(
                    builder: (context, state, _) {
                      return ListView.builder(
                        itemCount: state.length,
                        itemBuilder: (context, index) {
                          return Focus(
                            onFocusChange: (hasFocus) {
                              if (hasFocus) state.setFocus(state.typeAt(index));
                            },
                            child: SmartTextField(
                              type: state.typeAt(index),
                              controller: state.textAt(index),
                              focusNode: state.nodeAt(index),
                            )
                          );
                        }
                      );
                    }
                  ),
                ),
                if (showToolbar) Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Selector<EditorProvider, SmartTextType>(
                    selector: (buildContext, state) => state.selectedType,
                    builder: (context, selectedType, _) {
                      return Toolbar(
                        selectedType: selectedType,
                        onSelected: Provider.of<EditorProvider>(context,
                          listen: false).setType,
                      );
                    },
                  ),
                )
              ],
            )
          ),
        );
      }
    );
  }
}