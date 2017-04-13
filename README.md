# FF_RefreshControl
图片动画下拉刷新 和 转圈上拉加载更多

使用方法:

本刷新类是继承MJRefresh的子类 所以使用格式和其一样 :

    //头刷新
    __weak typeof(self) weakSelf = self;
    WealthGifHeader *header = [WealthGifHeader headerWithRefreshingBlock:^{
        weakSelf.isRefreshing = YES;
        weakSelf.currentPage = 0;
        [weakSelf queryData];
    }];         
    //尾刷新
    WealthRefreshFooter *footer = [WealthRefreshFooter footerWithRefreshingBlock:^{
        weakSelf.isRefreshing = NO;
        weakSelf.currentPage++;
        [weakSelf queryData];
    }];
    
    self.tableView.mj_footer = footer;
