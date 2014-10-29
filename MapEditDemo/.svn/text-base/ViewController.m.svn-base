/**
 * <p>
 * Title:地图编辑
 * </p>
 *
 * <p>
 * Description:
 * ============================================================================>
 * ------------------------------版权声明----------------------------
 * 此文件为 SuperMap iMobile 的演示Demo的代码
 * 版权所有：北京超图软件股份有限公司
 * ----------------------------------------------------------------
 * ---------------------SuperMap iMobile  演示Demo说明------------------------
 *
 * 1、Demo简介：示范如何运用导航模块实现路径导航
 * 2、Demo数据：数据目录："Document/EditData/"
 *          地图数据："changchun.smwu", "changchun.udb", "changchun.udd", "edit.udb", "edit.udd"
 *
 * 3、关键类型/成员:
 *    [Layer setEditable];                          方法
 *    [MapControl setAction];                       方法
 *    [MapControl submit];                          方法
 *    [MapControl addGeometrySelectedListener];     方法
 *    [MapControl addActionChangedListener];        方法
 *    [MapControl addMeasureListener];              方法
 *    [MapControl setStrokeColor];                  方法
 *    [MapControl setStrokeWidth];                  方法
 *    [MapControl undo];                            方法
 *    [MapControl redo];                            方法
 *
 * 4、功能展示
 *   (1)添加点、线、面、自由线、自由面，涂鸦；
 *   (2)编辑、添加、删除节点，删除对象；
 *   (3)距离，面积量算。
 *
 * ------------------------------------------------------------------------------
 * ============================================================================>
 * </p>
 *
 * <p>
 * Company: 北京超图软件股份有限公司
 * </p>
 *
 */

#import "ViewController.h"
#import "Common.h"
#import "SegImp.h"
#import "SegImpSecond.h"
#import "EditManager.h"
#import "CustomSegmentedControl.h"

@interface ViewController ()
{
    NSMutableArray* _segImpSecondArr;
    SegImp* _segImp;
    EditManager* _em;
    UIView* submitView;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self p_init];
    [self p_initView];
    [self p_openMap];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

/**
 *打开地图
*/
-(void)p_openMap
{
    
    if (_isWorkSpaceOpen) {
        
        BOOL isOpenMap = [m_mapControl.map open:@"长春市区图"];
        if (isOpenMap) {
            NSLog(@"Open Map Success!");
            [m_mapControl setAction:PAN];
            [m_mapControl.map viewEntire];
        }else {
            NSLog(@"Open Map Failed!");
        }
        
    }else {
        NSLog(@"Open Workspace Failed!");
    }
}
#pragma mark 初始化相关

/**
 *环境初始化
*/
-(void)p_init
{
    if (_workspace == nil) {
        // 初始化工作空间
        _workspace = [[Workspace alloc]init];
    }
    //打开工作空间
    NSString *srcfileName = [[NSBundle mainBundle] pathForResource:@"demoData" ofType:@"bundle"];
    
    NSArray *fileList = [[NSArray alloc] init];
    fileList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:srcfileName error:nil];
    
    for(NSString* each in fileList)
    {
        
        NSString *fileName = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",each];
        if(![[NSFileManager defaultManager] copyItemAtPath:[srcfileName stringByAppendingFormat:@"/%@",each] toPath:fileName error:nil])
            NSLog(@"拷贝数据失败");
    }
    NSString* workspace = [NSHomeDirectory() stringByAppendingString:@"/Documents/Changchun.smwu"];
    
    WorkspaceConnectionInfo *m_Info = [[WorkspaceConnectionInfo alloc]init];
    m_Info.server = workspace;
    //设置工作空间类型
    m_Info.type = SM_SMWU;
    //打开工作空间
    _isWorkSpaceOpen = [_workspace open:m_Info];
    
    [m_mapControl mapControlInit];
    m_mapControl.isMagnifierEnabled = YES;
    [m_mapControl.map setWorkspace:_workspace];
    
    _segImp = [[SegImp alloc]init];
    _segImp.delegate = self;
    _segImpSecondArr = [NSMutableArray array];
    
    _em = [[EditManager alloc]init];
    _em.m_mapcontrol = m_mapControl;
    _em.segImpSecondArr =  _segImpSecondArr;
    m_mapControl.delegate = _em;

}

/**
 *UI初始化
*/
-(void)p_initView
{
    
    NSMutableArray* _btnArr = [NSMutableArray array];
    
    UIView* mainView = [[UIView alloc]initWithFrame:CGRectMake(30.0, 20.0, 640.0, 75.0)];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.layer.borderWidth = 0.6;
    mainView.layer.borderColor = [[UIColor blackColor] CGColor];

  
    NSArray* imgArr = @[@"编辑未选_添加对象.png",@"编辑未选_编辑对象.png",@"03-编辑未选_量算.png"
,@"编辑未选_撤销.png",@"编辑未选_重做.png",@"编辑未选_取消.png",@"编辑未选_提交.png",@"编辑未选_风格设置.png"];
    NSArray* imgArrSel = @[@"编辑选中_添加对象.png",@"编辑选中_编辑对象.png",@"03-编辑选中_量算.png",@"编辑选中_撤销.png",@"编辑选中_重做.png",@"编辑选中_取消.png",@"编辑选中_提交.png",@"编辑选中_风格设置.png"];
    for (int i=0; i<8; i++)
    {
        UIButton* button = [[UIButton alloc]initWithFrame:CGRectMake(i*80, 0, 80, 75)];
        
        button.tag = i;
        [button setBackgroundImage:[UIImage imageNamed:[imgArr objectAtIndex:i]] forState:UIControlStateNormal];
        
        if(i>=3 && i<=6)
            [button setBackgroundImage:[UIImage imageNamed:[imgArrSel objectAtIndex:i]] forState:UIControlStateHighlighted];
        else
            [button setBackgroundImage:[UIImage imageNamed:[imgArrSel objectAtIndex:i]] forState:UIControlStateSelected];

        button.layer.borderWidth = 0.6;
        button.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        
        [_btnArr addObject:button];
        [mainView addSubview:button];
        
    }
    _segImp.btnArr = _btnArr;
    _segImp.m_mapControl = m_mapControl;
    _segImp.em = _em;
    [_segImp process];
   [self.view addSubview:mainView];
    
    for(int i=0;i<4;i++)
    {
        SegImpSecond* sis = [[SegImpSecond alloc]init];
        sis.tag = i;
        sis.delegate = _em;
        UIView* tmp = [sis process];
        [self.view addSubview:tmp];
        [_segImpSecondArr addObject:sis];
    }
    
    submitView = [[UIView alloc]initWithFrame:CGRectMake(435.0, 95.0, 230.0, 130)];
    submitView.backgroundColor = [UIColor clearColor];
    UIImageView* img = [[UIImageView alloc]initWithImage:[Common scaleToSize:[UIImage imageNamed:@"bg_submit.png"] size:CGSizeMake(230, 130)]];
    [submitView addSubview:img];
    UILabel* lable = [[UILabel alloc]initWithFrame:CGRectMake(1, 10, 230.0, 100)];
    lable.lineBreakMode = NSLineBreakByTruncatingMiddle;
    lable.textAlignment =  NSTextAlignmentCenter;
    lable.numberOfLines = 0;
    lable.textColor = [UIColor colorWithRed:77.0f/255.0f green:197.0f/255.0f blue:195.0f/255.0f alpha:1.0f];
    lable.text = @"缺少可编辑该对象类型图层";
    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(170, 100, 40, 25)];
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClickSubmit:) forControlEvents:UIControlEventTouchUpInside];
    submitView.hidden = YES;
    
    [submitView addSubview:lable];
    [submitView addSubview:btn];
    [self.view addSubview:submitView];
}

#pragma mark 协议相关

/**
 *创建二级菜单
*/
- (UIButton *) buttonFor:(CustomSegmentedControl *)segmentedControl atIndex:(NSUInteger)segmentIndex
{
    NSArray* imgArr = @[@"编辑未选_添加对象.png",@"编辑未选_编辑对象.png",@"编辑未选_撤销.png",@"编辑未选_重做.png",@"编辑未选_取消.png",@"编辑未选_提交.png",@"编辑未选_风格设置.png"];
    NSArray* imgArrSel = @[@"编辑选中_添加对象.png",@"编辑选中_编辑对象.png",@"编辑选中_撤销.png",@"编辑选中_重做.png",@"编辑选中_取消.png",@"编辑选中_提交.png",@"编辑选中_风格设置.png"];
    UIButton* button = [[UIButton alloc]initWithFrame:CGRectMake(segmentIndex*80, 0, 80, 70.0)];
    button.tag = segmentIndex;
    [button setBackgroundImage:[UIImage imageNamed:[imgArr objectAtIndex:segmentIndex]] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:[imgArrSel objectAtIndex:segmentIndex]] forState:UIControlStateSelected];
    
    return button;
}

/**
 *界面更新回调
*/
-(void)notifyToView
{
    for(SegImpSecond* sis in _segImpSecondArr)
        sis.mainView.hidden = YES;
    for(UIButton* btn in _segImp.btnArr)
        btn.selected = NO;
    submitView.hidden = NO;
}

/**
 *二级菜单响应一级菜单回调
*/
- (void) createSeg:(int)segmentIndex
{
    submitView.hidden = YES;
    switch (segmentIndex) {
        case 0:
        {
            SegImpSecond* sis = [_segImpSecondArr objectAtIndex:1];
            sis.mainView.hidden = !sis.mainView.hidden;
            for(SegImpSecond* each in _segImpSecondArr){
                if(each == sis){
                    [_em reset];
                    continue;
                }
                each.mainView.hidden = YES;
            }
            break;
        }
        case 1:
        {
           SegImpSecond* sis = [_segImpSecondArr objectAtIndex:2];
            sis.mainView.hidden = !sis.mainView.hidden;
            for(SegImpSecond* each in _segImpSecondArr){
                if(each == sis){
                    [_em reset];
                    continue;
                }
                each.mainView.hidden = YES;
            }
            break;
        }
        case 2:
        {
            SegImpSecond* sis1 = [_segImpSecondArr objectAtIndex:0];
            sis1.mainView.hidden = !sis1.mainView.hidden ;
           for(SegImpSecond* each in _segImpSecondArr){
                if(each == sis1){
                    [_em reset];
                    continue;
                }
                each.mainView.hidden = YES;
            }

            break;
        }
        case 7:
        {
            SegImpSecond* sis2 = [_segImpSecondArr objectAtIndex:3];
            sis2.mainView.hidden = !sis2.mainView.hidden ;
            for(SegImpSecond* each in _segImpSecondArr){
                if(each == sis2){
                    [_em reset];
                    continue;
                }
                each.mainView.hidden = YES;
            }
            break;
        }
    }
}

#pragma mark 按键响应相关

/**
 *提交对话框
*/
-(void)btnClickSubmit:(id)sender
{
    submitView.hidden = YES;
}

/**
 *全幅
*/
-(IBAction)btnFullmap:(id)sender
{
        [m_mapControl.map viewEntire];
        [m_mapControl.map refresh];
}

/**
 *放大
*/
-(IBAction)btnZoomOut:(id)sender
{
        [m_mapControl.map zoom:0.5];
        [m_mapControl.map refresh];
}

/**
 *缩小
*/
-(IBAction)btnZoomIn:(id)sender
{
        [m_mapControl.map zoom:2];
        [m_mapControl.map refresh];
}

@end