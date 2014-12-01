unit ufrmBTFMain;

{$mode objfpc}{$H+}

interface

uses
  JwaTlHelp32,
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons;

type

  { Tfrmbtfmain }

  Tfrmbtfmain = class(TForm)
    btnSetToRight: TButton;
    btnSetNoTopMost: TButton;
    ComboBox1: TComboBox;
    btnRefreshWindows: TSpeedButton;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmbtfmain: Tfrmbtfmain;

implementation

{$R *.lfm}

function EnumWindowsProc3(Wnd: THandle; lb: TListbox): Boolean; stdcall;
var
    caption: Array [0..128] of Char;
begin
    Result := True;
    if IsWindowVisible(Wnd) and
    ((GetWindowLong(Wnd, GWL_HWNDPARENT) = 0) or
    (HWND(GetWindowLong(Wnd, GWL_HWNDPARENT)) = GetDesktopWindow))and
    ((GetWindowLong(Wnd, GWL_EXSTYLE) and WS_EX_TOOLWINDOW) = 0)
    then
    begin
        SendMessage( Wnd, WM_GETTEXT, Sizeof(caption), Integer(@caption));
        frmUpToFront.ComboBox1.Items.AddObject( caption, TObject( Wnd ));
    end;
end;

end.

