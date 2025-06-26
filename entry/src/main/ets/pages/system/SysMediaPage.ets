class BeanMedia {
  title: string = ''
  res: Resource | undefined

  constructor(title: string, res: Resource) {
    this.title = title
    this.res = res
  }
}

let medias: BeanMedia[] = [
  new BeanMedia('ohos_app_icon', $r('sys.media.ohos_app_icon')),
  new BeanMedia('ohos_ic_back', $r('sys.media.ohos_ic_back')),
  new BeanMedia('ohos_ic_public_ok', $r('sys.media.ohos_ic_public_ok')),
  new BeanMedia('ohos_ic_public_arrow_left', $r('sys.media.ohos_ic_public_arrow_left')),
  new BeanMedia('ohos_ic_public_arrow_right', $r('sys.media.ohos_ic_public_arrow_right')),
  new BeanMedia('ohos_ic_public_arrow_up', $r('sys.media.ohos_ic_public_arrow_up')),
  new BeanMedia('ohos_ic_public_arrow_down', $r('sys.media.ohos_ic_public_arrow_down')),
  new BeanMedia('ohos_ic_public_cut', $r('sys.media.ohos_ic_public_cut')),
  new BeanMedia('ohos_ic_public_copy', $r('sys.media.ohos_ic_public_copy')),
  new BeanMedia('ohos_ic_public_paste', $r('sys.media.ohos_ic_public_paste')),
  new BeanMedia('ohos_ic_public_select_all', $r('sys.media.ohos_ic_public_select_all')),
  new BeanMedia('ohos_ic_public_share', $r('sys.media.ohos_ic_public_share')),
  new BeanMedia('ohos_ic_public_translate_c2e', $r('sys.media.ohos_ic_public_translate_c2e')),
  new BeanMedia('ohos_ic_public_search_filled', $r('sys.media.ohos_ic_public_search_filled')),
  new BeanMedia('ohos_save_button_filled', $r('sys.media.ohos_save_button_filled')),
  new BeanMedia('ohos_save_button_line', $r('sys.media.ohos_save_button_line')),
  new BeanMedia('ohos_ic_bottomsheet_close', $r('sys.media.ohos_ic_bottomsheet_close')),
  new BeanMedia('ohos_ic_public_clock', $r('sys.media.ohos_ic_public_clock')),
  new BeanMedia('ohos_ic_public_email', $r('sys.media.ohos_ic_public_email')),
  new BeanMedia('ohos_ic_public_express', $r('sys.media.ohos_ic_public_express')),
  new BeanMedia('ohos_ic_public_flight', $r('sys.media.ohos_ic_public_flight')),
  new BeanMedia('ohos_ic_public_location', $r('sys.media.ohos_ic_public_location')),
  new BeanMedia('ohos_ic_public_phone', $r('sys.media.ohos_ic_public_phone')),
  new BeanMedia('ohos_ic_public_text', $r('sys.media.ohos_ic_public_text')),
  new BeanMedia('ohos_ic_public_web', $r('sys.media.ohos_ic_public_web')),
  new BeanMedia('ohos_ic_public_device_matebook', $r('sys.media.ohos_ic_public_device_matebook')),
  new BeanMedia('ohos_ic_public_device_pad', $r('sys.media.ohos_ic_public_device_pad')),
  new BeanMedia('ohos_ic_public_device_smartscreen', $r('sys.media.ohos_ic_public_device_smartscreen')),
  new BeanMedia('ohos_ic_public_device_watch', $r('sys.media.ohos_ic_public_device_watch')),
  new BeanMedia('ohos_ic_public_device_phone', $r('sys.media.ohos_ic_public_device_phone')),
  new BeanMedia('ohos_ic_eco_hop', $r('sys.media.ohos_ic_eco_hop')),
  new BeanMedia('ohos_ic_public_more', $r('sys.media.ohos_ic_public_more')),
  new BeanMedia('ohos_ic_public_add', $r('sys.media.ohos_ic_public_add')),
  new BeanMedia('ohos_ic_public_minus', $r('sys.media.ohos_ic_public_minus')),
  new BeanMedia('ohos_ic_public_cast_stream', $r('sys.media.ohos_ic_public_cast_stream')),
  new BeanMedia('ohos_ic_public_cast_mirror', $r('sys.media.ohos_ic_public_cast_mirror')),
  new BeanMedia('ohos_ic_public_camera', $r('sys.media.ohos_ic_public_camera')),
  new BeanMedia('ohos_ic_public_cancel', $r('sys.media.ohos_ic_public_cancel')),
  new BeanMedia('ohos_ic_public_hang_up', $r('sys.media.ohos_ic_public_hang_up')),
  new BeanMedia('ohos_ic_public_pause', $r('sys.media.ohos_ic_public_pause')),
  new BeanMedia('ohos_ic_public_play_last', $r('sys.media.ohos_ic_public_play_last')),
  new BeanMedia('ohos_ic_public_play_next', $r('sys.media.ohos_ic_public_play_next')),
  new BeanMedia('ohos_ic_public_play', $r('sys.media.ohos_ic_public_play')),
  new BeanMedia('ohos_ic_public_restore', $r('sys.media.ohos_ic_public_restore')),
  new BeanMedia('ohos_ic_public_sound_off', $r('sys.media.ohos_ic_public_sound_off')),
  new BeanMedia('ohos_ic_public_sound', $r('sys.media.ohos_ic_public_sound')),
  new BeanMedia('ohos_ic_public_video_off', $r('sys.media.ohos_ic_public_video_off')),
  new BeanMedia('ohos_ic_public_video', $r('sys.media.ohos_ic_public_video')),
  new BeanMedia('ohos_ic_public_voice_off', $r('sys.media.ohos_ic_public_voice_off')),
  new BeanMedia('ohos_ic_public_voice', $r('sys.media.ohos_ic_public_voice')),
  new BeanMedia('ohos_ic_public_albums', $r('sys.media.ohos_ic_public_albums')),
  new BeanMedia('ohos_ic_public_scan', $r('sys.media.ohos_ic_public_scan')),
  new BeanMedia('ohos_ic_public_add_norm_filled', $r('sys.media.ohos_ic_public_add_norm_filled')),
  new BeanMedia('ohos_ic_public_remove_filled', $r('sys.media.ohos_ic_public_remove_filled')),
  new BeanMedia('ohos_ic_public_edit', $r('sys.media.ohos_ic_public_edit')),
  new BeanMedia('ohos_ic_public_fail', $r('sys.media.ohos_ic_public_fail')),
  new BeanMedia('ohos_ic_public_close', $r('sys.media.ohos_ic_public_close')),
  new BeanMedia('ohos_ic_compnent_titlebar_back', $r('sys.media.ohos_ic_compnent_titlebar_back')),
  new BeanMedia('ohos_ic_compnent_titlebar_back_filled', $r('sys.media.ohos_ic_compnent_titlebar_back_filled')),
  new BeanMedia('ohos_ic_public_cancel_filled', $r('sys.media.ohos_ic_public_cancel_filled')),
  new BeanMedia('ohos_ic_public_drawer_close', $r('sys.media.ohos_ic_public_drawer_close')),
  new BeanMedia('ohos_ic_public_drawer_close_filled', $r('sys.media.ohos_ic_public_drawer_close_filled')),
  new BeanMedia('ohos_ic_public_drawer_open', $r('sys.media.ohos_ic_public_drawer_open')),
  new BeanMedia('ohos_ic_public_drawer_open_filled', $r('sys.media.ohos_ic_public_drawer_open_filled')),
  new BeanMedia('ohos_ic_public_input_cancel', $r('sys.media.ohos_ic_public_input_cancel')),
  new BeanMedia('ohos_ic_normal_white_grid_zip', $r('sys.media.ohos_ic_normal_white_grid_zip')),
  new BeanMedia('ohos_ic_normal_white_grid_xml', $r('sys.media.ohos_ic_normal_white_grid_xml')),
  new BeanMedia('ohos_ic_normal_white_grid_xls', $r('sys.media.ohos_ic_normal_white_grid_xls')),
  new BeanMedia('ohos_ic_normal_white_grid_wma', $r('sys.media.ohos_ic_normal_white_grid_wma')),
  new BeanMedia('ohos_ic_normal_white_grid_wav', $r('sys.media.ohos_ic_normal_white_grid_wav')),
  new BeanMedia('ohos_ic_normal_white_grid_video', $r('sys.media.ohos_ic_normal_white_grid_video')),
  new BeanMedia('ohos_ic_normal_white_grid_txt', $r('sys.media.ohos_ic_normal_white_grid_txt')),
  new BeanMedia('ohos_ic_normal_white_grid_pdf', $r('sys.media.ohos_ic_normal_white_grid_pdf')),
  new BeanMedia('ohos_ic_normal_white_grid_mp3', $r('sys.media.ohos_ic_normal_white_grid_mp3')),
  new BeanMedia('ohos_ic_normal_white_grid_image', $r('sys.media.ohos_ic_normal_white_grid_image')),
  new BeanMedia('ohos_ic_normal_white_grid_html', $r('sys.media.ohos_ic_normal_white_grid_html')),
  new BeanMedia('ohos_ic_normal_white_grid_folder', $r('sys.media.ohos_ic_normal_white_grid_folder')),
  new BeanMedia('ohos_ic_normal_white_grid_flac', $r('sys.media.ohos_ic_normal_white_grid_flac')),
  new BeanMedia('ohos_ic_normal_white_grid_doc', $r('sys.media.ohos_ic_normal_white_grid_doc')),
  new BeanMedia('ohos_ic_normal_white_grid_compress', $r('sys.media.ohos_ic_normal_white_grid_compress')),
  new BeanMedia('ohos_ic_normal_white_grid_calendar', $r('sys.media.ohos_ic_normal_white_grid_calendar')),
  new BeanMedia('ohos_ic_normal_white_grid_audio', $r('sys.media.ohos_ic_normal_white_grid_audio')),
  new BeanMedia('ohos_icon_mask_svg', $r('sys.media.ohos_icon_mask_svg')),
  new BeanMedia('ohos_ic_public_remove', $r('sys.media.ohos_ic_public_remove')),
  new BeanMedia('ohos_user_auth_icon_face', $r('sys.media.ohos_user_auth_icon_face')),
  new BeanMedia('ohos_user_auth_icon_fingerprint', $r('sys.media.ohos_user_auth_icon_fingerprint')),
  new BeanMedia('ohos_ic_public_device_bluetooth_filled', $r('sys.media.ohos_ic_public_device_bluetooth_filled')),
  new BeanMedia('ohos_ic_public_device_earphone_filled', $r('sys.media.ohos_ic_public_device_earphone_filled')),
  new BeanMedia('ohos_ic_public_device_earpiece_filled', $r('sys.media.ohos_ic_public_device_earpiece_filled')),
  new BeanMedia('ohos_ic_public_device_speaker_filled', $r('sys.media.ohos_ic_public_device_speaker_filled')),
  new BeanMedia('ohos_ic_public_device_sound_filled', $r('sys.media.ohos_ic_public_device_sound_filled')),
  new BeanMedia('ohos_ic_public_device_soundx_filled', $r('sys.media.ohos_ic_public_device_soundx_filled')),
  new BeanMedia('ohos_ic_public_device_smartscreen_filled', $r('sys.media.ohos_ic_public_device_smartscreen_filled')),
  new BeanMedia('ohos_ic_public_ok_filled', $r('sys.media.ohos_ic_public_ok_filled')),
  new BeanMedia('save_button_picture', $r('sys.media.save_button_picture')),
  new BeanMedia('clone_app_badge_1', $r('sys.media.clone_app_badge_1')),
  new BeanMedia('clone_app_badge_2', $r('sys.media.clone_app_badge_2')),
  new BeanMedia('clone_app_badge_3', $r('sys.media.clone_app_badge_3')),
  new BeanMedia('clone_app_badge_4', $r('sys.media.clone_app_badge_4')),
  new BeanMedia('clone_app_badge_5', $r('sys.media.clone_app_badge_5')),
  new BeanMedia('ic_public_worldclock_filled', $r('sys.media.ic_public_worldclock_filled')),
  new BeanMedia('ic_public_ai_write', $r('sys.media.ic_public_ai_write')),
  new BeanMedia('Copy_Drag', $r('sys.media.Copy_Drag')),
  new BeanMedia('Copy_One_Drag', $r('sys.media.Copy_One_Drag')),
  new BeanMedia('Forbid_Drag', $r('sys.media.Forbid_Drag')),
  new BeanMedia('Forbid_One_Drag', $r('sys.media.Forbid_One_Drag')),
  new BeanMedia('Move_Drag', $r('sys.media.Move_Drag')),
  new BeanMedia('safe_volume_notification_icon', $r('sys.media.safe_volume_notification_icon')),
  new BeanMedia('ohos_ic_window_menu_screen_t', $r('sys.media.ohos_ic_window_menu_screen_t')),
  new BeanMedia('ohos_ic_window_menu_screen_b', $r('sys.media.ohos_ic_window_menu_screen_b')),
  new BeanMedia('ohos_ic_window_menu_waterfall', $r('sys.media.ohos_ic_window_menu_waterfall')),
  new BeanMedia('ic_public_camera_beauty', $r('sys.media.ic_public_camera_beauty')),
  new BeanMedia('ohos_ic_window_menu_moveto_t', $r('sys.media.ohos_ic_window_menu_moveto_t')),
  new BeanMedia('ohos_ic_window_menu_moveto_b', $r('sys.media.ohos_ic_window_menu_moveto_b')),
  new BeanMedia('ohos_ic_window_menu_back', $r('sys.media.ohos_ic_window_menu_back')),
]

class BasicDataSourceMedia implements IDataSource {
  totalCount(): number {
    return medias.length
  }

  getData(index: number): BeanMedia {
    return medias[index]
  }

  registerDataChangeListener(listener: DataChangeListener): void {
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
  }
}


@Entry
@Component
struct SysMediaPage {
  @State message: string = 'Hello World';
  private data: BasicDataSourceMedia = new BasicDataSourceMedia()

  build() {
    List() {
      LazyForEach(this.data, (item: BeanMedia) => {
        ListItem() {
          Row() {
            Image(item.res)
              .width(20)
              .height(20)
            Blank()
              .width(10)
            Text(item.title).fontSize(11)
              .textOverflow({ overflow: TextOverflow.MARQUEE })
              .textAlign(TextAlign.Start)
              .onAppear(() => {
                console.info(`appear: ${item}`);
              })
          }.margin({ left: 10, right: 10, bottom: 5 })
        }
      })
    }
    .height('100%')
    .width('100%')
  }
}