(*
Simple program designed to put a window in operaciona windows system always in
front.
*)
unit ufrmBTFMain;

{$mode objfpc}{$H+}

interface

uses
  Windows,
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons;

type
//  HWND = type LongWord;
//  BOOL = LongBool;
  { Tfrmbtfmain }

  Tfrmbtfmain = class(TForm)
    btnSetToRight: TButton;
    btnSetNoTopMost: TButton;
    cmbWindows: TComboBox;
    btnRefreshWindows: TSpeedButton;
    procedure btnRefreshWindowsClick(Sender: TObject);
    procedure btnSetNoTopMostClick(Sender: TObject);
    procedure btnSetToRightClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmbtfmain: Tfrmbtfmain;

implementation

{$R *.lfm}

function EnumWindowsProc(Wnd: HWND; LParM: LParam): LongBool; stdCall; export;
var
  caption: Array [0..128] of Char;
begin
  Result := True;
  if IsWindowVisible(Wnd)
  and (
      (GetWindowLong(Wnd, GWL_HWNDPARENT) = 0)
      or  (HWND(GetWindowLong(Wnd, GWL_HWNDPARENT)) = GetDesktopWindow)
  )
  and (
      (GetWindowLong(Wnd, GWL_EXSTYLE) and WS_EX_TOOLWINDOW) = 0
  )
  then
  begin
    SendMessage( Wnd, WM_GETTEXT, Sizeof(caption), Integer(@caption));
    frmbtfmain.cmbWindows.Items.AddObject( caption, TObject( Wnd ));
  end;
end;

{ Tfrmbtfmain }

procedure Tfrmbtfmain.btnRefreshWindowsClick(Sender: TObject);
begin
  cmbWindows.Items.Clear;
  EnumWindows(@EnumWindowsProc, 0);
end;

procedure Tfrmbtfmain.btnSetNoTopMostClick(Sender: TObject);
var
  hWnd: LongWord;
begin
  hWnd := FindWindow(nil, PChar(cmbWindows.Text));
  SetWindowPos(hWnd, HWND_NOTOPMOST, 0,0,0,0, SWP_NOMOVE+SWP_NOSIZE);
  SetForegroundWindow(hWnd);
end;

procedure Tfrmbtfmain.btnSetToRightClick(Sender: TObject);
var
  hWnd: LongWord;
begin
  hWnd := FindWindow(nil, PChar(cmbWindows.Text));
  SetWindowPos(hWnd, HWND_TOPMOST, 0,0,0,0, SWP_NOMOVE+SWP_NOSIZE);
  SetForegroundWindow(hWnd);
end;

procedure Tfrmbtfmain.FormCreate(Sender: TObject);
begin
  btnRefreshWindowsClick(btnRefreshWindows);
end;

end.

