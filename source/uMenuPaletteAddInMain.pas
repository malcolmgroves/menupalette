unit uMenuPaletteAddInMain;

interface

uses
  Windows, ToolsAPI;

type
  TmgMenuPaletteWizard = class(TInterfacedObject, IOTAWizard)
  private
    procedure LoadPalette;
    procedure UnloadPalette;
  public
    procedure Execute;
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;
    procedure AfterSave;
    procedure BeforeSave;
    procedure Destroyed;
    procedure Modified;
    constructor Create; 
  end;

procedure Register;

implementation

uses
  PaletteAPI, uMenuPaletteItem, ActnList;

const
  mgMenuGroup = 'mgMenuGroup';

{ TmgMenuPaletteWizard }

procedure TmgMenuPaletteWizard.AfterSave;
begin
  inherited;
  // not called for IOTAWizards
end;

procedure TmgMenuPaletteWizard.BeforeSave;
begin
  inherited;
  // not called for IOTAWizards
end;

constructor TmgMenuPaletteWizard.Create;
begin
  inherited;
  LoadPalette;
end;

procedure TmgMenuPaletteWizard.Destroyed;
begin
  // The associated item is being destroyed so all references should be dropped.
  // Exceptions are ignored.
  UnloadPalette;
end;

procedure TmgMenuPaletteWizard.Execute;
begin
  // not used in this case, as work is done at initialization
end;

function TmgMenuPaletteWizard.GetIDString: string;
begin
  Result := 'com.malcolmgroves.MenuPaletteWizard';
end;

function TmgMenuPaletteWizard.GetName: string;
begin
  Result := 'Menu Palette';
end;

function TmgMenuPaletteWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

procedure TmgMenuPaletteWizard.LoadPalette;
var
  PaletteServices : IOTAPaletteServices;
  MenuGroup : IOTAPaletteGroup;
  MenuItem : TMenuPaletteItem;
  IDEActionList : TCustomActionList;
  I: Integer;
  CurrentAction : TCustomAction;
begin
  PaletteServices := (BorlandIDEServices as IOTAPaletteServices);
  MenuGroup := PaletteServices.BaseGroup.AddGroup('Menu Items', mgMenuGroup);
  if MenuGroup <> nil then
  begin
    // get the mainmenu
    IDEActionList := (BorlandIDEServices as INTAServices).ActionList;
    if IDEActionList <> nil then
    begin
      for I := 0 to IDEActionList.ActionCount - 1 do
      begin
        if IDEActionList.Actions[I] is TCustomAction then
        begin
          CurrentAction := TCustomAction(IDEActionList.Actions[I]);
          // make sure it's not an internal or irrelevant action
          // (there seem to be some weird ones I probably should not surface)
          if (CurrentAction.Caption <> 'actnCompDummy') or
             (CurrentAction.Caption <> 'actnMMDummyRefresh') or
             (CurrentAction.Caption <> '') or
             (CurrentAction.Caption <> '-') then
          begin
            MenuItem := TMenuPaletteItem.Create;
            MenuItem.Action := CurrentAction;
            MenuGroup.AddItem(MenuItem as IOTABasePaletteItem);
          end;
        end;
      end;
    end;
  end;
end;

procedure TmgMenuPaletteWizard.Modified;
begin
  // not called for IOTAWizards
end;

procedure TmgMenuPaletteWizard.UnloadPalette;
var
  PaletteServices : IOTAPaletteServices;
  MenuGroup : IOTAPaletteGroup;
begin
  PaletteServices := (BorlandIDEServices as IOTAPaletteServices);
  if PaletteServices <> nil then
  begin
    MenuGroup := PaletteServices.BaseGroup.FindItemGroup(mgMenuGroup);
    if MenuGroup <> nil then
    begin
      while MenuGroup.Count > 0 do
      begin
        MenuGroup.RemoveItem(MenuGroup.Items[MenuGroup.Count - 1].IDString, False);
      end;
    end;
  end;
end;

procedure Register;
begin
  RegisterPackageWizard(TmgMenuPaletteWizard.Create);
end;


end.
