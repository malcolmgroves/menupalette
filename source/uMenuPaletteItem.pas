unit uMenuPaletteItem;

interface
uses
  PaletteAPI, Graphics, ActnList;

type
  TMenuPaletteItem = class(TInterfacedObject, IOTABasePaletteItem, INTAPalettePaintIcon)
  private
    FAction : TCustomAction;
  protected
    function GetCanDelete: Boolean;
    function GetHelpName: string;
    function GetHintText: string;
    function GetIDString: string;
    function GetName: string;
    function GetVisible: Boolean;
    procedure SetHelpName(const Value: string);
    procedure SetName(const Value: string);
    procedure SetVisible(const Value: Boolean);
    procedure SetHintText(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    { If this item can be deleted (permanently), return true.
      When Delete is called, you should remove the item (permanently) }
    property CanDelete: Boolean read GetCanDelete;
    { HelpName: used for displaying a help page for this item }
    property HelpName: string read GetHelpName write SetHelpName;
    { HintText: The tool tip that is displayed for this item }
    property HintText: string read GetHintText write SetHintText;
    { IDString: uniquely identifies the item, and never changes }
    property IDString: string read GetIDString;
    { Name: the display name for a given item }
    property Name: string read GetName write SetName;
    { Visible: if the item should be shown or not. Items should
      be hidden when they are not valid for the current designer. Hidden
      items may be shown when customizing the palette. }
    property Visible: Boolean read GetVisible write SetVisible;
    { Execute: call it when you want this item to create itself
      or execute its action. Groups will do nothing. Palette items
      will typically create themselves. }
    procedure Execute;
    { Delete is called when an item is removed from the IDE permanently.
      CanDelete should be checked before calling Delete. }
    procedure Delete;
    procedure Paint(const Canvas: TCanvas; const X, Y: Integer;
      const IconSize: TNTAPaintIconSize);
    property Action : TCustomAction read FAction write FAction;
  end;


implementation
uses
  ImgList, SysUtils, ToolsAPI;

{ TMenuPaletteItem }

constructor TMenuPaletteItem.Create;
begin
  inherited;
  Action := nil;
end;

procedure TMenuPaletteItem.Delete;
begin
  Action := nil;
end;

destructor TMenuPaletteItem.Destroy;
begin
  if Assigned(FAction) then
    Action := nil;
  inherited;
end;

procedure TMenuPaletteItem.Execute;
begin
  if Assigned(FAction) then
    Action.Execute;
end;

function TMenuPaletteItem.GetCanDelete: Boolean;
begin
  Result := false;
end;

function TMenuPaletteItem.GetHelpName: string;
begin
  if Assigned(FAction) then
    Result := Action.HelpKeyword;
end;

function TMenuPaletteItem.GetHintText: string;
begin
  if Assigned(FAction) then
    Result := Action.Hint;
end;

function TMenuPaletteItem.GetIDString: string;
begin
  if Assigned(FAction) then
    Result := Action.Caption;
end;

function TMenuPaletteItem.GetName: string;
begin
  if Assigned(FAction) then
    Result := StringReplace(Action.Caption, '&', '', [rfReplaceAll]);
end;

function TMenuPaletteItem.GetVisible: Boolean;
begin
  if Assigned(FAction) then
    Result := Action.Enabled
  else
    Result := false;
end;

procedure TMenuPaletteItem.Paint(const Canvas: TCanvas; const X, Y: Integer;
  const IconSize: TNTAPaintIconSize);
var
  IDEImageList : TCustomImageList;
begin
  if Assigned(FAction) then
  begin
    IDEImageList := (BorlandIDEServices as INTAServices).ImageList;
    if Assigned(IDEImageList) then
      IDEImageList.Draw(Canvas, X, Y, Action.ImageIndex, dsTransparent, itImage);
  end;
end;

procedure TMenuPaletteItem.SetHelpName(const Value: string);
begin
  //
end;

procedure TMenuPaletteItem.SetHintText(const Value: string);
begin
  //
end;

procedure TMenuPaletteItem.SetName(const Value: string);
begin
  //
end;

procedure TMenuPaletteItem.SetVisible(const Value: Boolean);
begin
  //
end;


end.
