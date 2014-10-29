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
 * 2、Demo：数据目录："Document/EditData/"
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

#import <UIKit/UIKit.h>
#import <SuperMap/SuperMap.h>

#import "CustomSegmentedControl.h"
#import "SegImp.h"
@interface ViewController : UIViewController<CreateSegDelegate,CustomSegmentedControlDelegate>
{
    IBOutlet MapControl *m_mapControl;
    Workspace* _workspace;
    
    BOOL _isWorkSpaceOpen;
}


@end
