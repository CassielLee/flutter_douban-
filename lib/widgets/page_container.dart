import 'package:flutter/material.dart';
import 'package:flutter_douban/widgets/custom_loading.dart';

class PageContainer extends StatelessWidget {
  // 容器组件，提供页面的loading状态和error状态
  const PageContainer(
      {Key key,
      this.loading = false,
      this.error = false,
      this.empty = false,
      this.emptyText,
      this.loadingBuilder,
      this.errorBuilder,
      this.emptyBuilder,
      this.height,
      // 默认Loading样式，0默认，1加蒙层
      this.defaultLoadingType = 0,
      @required this.childBuilder,
      this.onLoad,
      this.emptyImage})
      : super(key: key);

  final bool loading;
  final bool error;
  final bool empty;
  final String emptyText;
  final WidgetBuilder loadingBuilder;
  final double height;
  final WidgetBuilder errorBuilder;
  final WidgetBuilder emptyBuilder;
  final int defaultLoadingType;
  final WidgetBuilder childBuilder;
  final Function onLoad;
  final Widget emptyImage;

  Widget _buildDefaultError(BuildContext context) {
    return Container(
        height: height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(children: <Widget>[
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/common/ic_error.png',
                      height: 200, width: 200),
                  SizedBox(height: 10),
                  Text("数据获取失败")
                ]),
          ),
          Container(
            child: RaisedButton(
              child: Text("重新加载",
                  style: TextStyle(color: Colors.white, fontSize: 15)),
              onPressed: onLoad,
            ),
          )
        ]));
  }

  // 构建默认的Loading页面
  Widget _buildDefaultLoading(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      width: MediaQuery.of(context).size.width,
      child: CustomLoading(),
    );
  }

  Widget _buildDefaultLoadingWithMask(BuildContext context) {
    return Stack(children: <Widget>[
      childBuilder(context),
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(5)),
        child: CustomLoading(),
      )
    ]);
  }

  // 构建空页面
  Widget _buildDefaultEmpty(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
                child: emptyImage ??
                    Image.asset('assets/images/common/is_dev_empty.png',
                        width: 130, height: 130)),
            SizedBox(height: 20),
            Text(emptyText ?? "暂无数据"),
            SizedBox(height: 100)
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (error) {
      WidgetBuilder _errorBuilder = errorBuilder;
      if (_errorBuilder == null) {
        _errorBuilder = _buildDefaultError;
      }
      return _errorBuilder(context);
    }
    if (loading) {
      WidgetBuilder _loadingBuilder = loadingBuilder;
      if (_loadingBuilder == null) {
        _loadingBuilder = defaultLoadingType == 0
            ? _buildDefaultLoading
            : _buildDefaultLoadingWithMask;
      }
      return _loadingBuilder(context);
    }
    if (empty) {
      WidgetBuilder _emptyBuilder = emptyBuilder;
      if (_emptyBuilder == null) {
        _emptyBuilder = _buildDefaultEmpty;
      }
      return _emptyBuilder(context);
    }
    return childBuilder(context);
  }
}
