module ComponentHelper
  DATA = {
    data: {
      tko: {
        logoText: 'Лендос!',
        items: [
          {
            title: 'О нас',
            url: 'google.ru',
          },
          {
            title: 'Услуги',
            url: 'services.ru',
          },
        ],
      },
      hello: {
        headerText: 'Отдельное спасибо <br />Death to the Stock Photo !',
        leadText: 'Отдельное спасибо <a target="_blank" href="http://join.deathtothestockphoto.com/">Death to the Stock Photo</a> за предоставленные фотографии которые Вы видите в этом шаблоне. <br />Посетите их сайт и получите доступ к огрмному количеству качественных фото.',
        image: {
          url: 'http://ironsummitmedia.github.io/startbootstrap-landing-page/img/ipad.png',
          height: 354,
          width: 458,
        },
      },
      hellov2: {
        headerText: '3D макеты на предметах<br /> от PSDCovers',
        leadText: 'Преврати свой двумерный дизайн в высококачественные, трехмерные снимки за секунды используя бесплатные экшены в Photoshop от <a target="_blank" href="http://www.psdcovers.com/">PSDCovers</a>!<br />Посетите их сайт чтобы скачать что-то восхитительное и увидить экшены в действии!',
        image: {
          url: 'http://ironsummitmedia.github.io/startbootstrap-landing-page/img/dog.png',
          height: 383,
          width: 458,
        },
      },
      hello2323: {
        headerText: 'Шрифты Google Web и<br>иконки Font Awesome',
        leadText: 'Этот шаблон применяет \'Lato\' шрифт, часть <a target="_blank" href="http://www.google.com/fonts">библиотеки Google Web Font</a>, также как и <a target="_blank" href="http://fontawesome.io">иконки из Font Awesome</a>.',
        image: {
          url: 'http://ironsummitmedia.github.io/startbootstrap-landing-page/img/phones.png',
          height: 302,
          width: 458,
        },
      },
      ctaMyBad: {
        text: 'Connect to BML landings:',
        backgroundImageUrl: 'http://ironsummitmedia.github.io/startbootstrap-landing-page/img/banner-bg.jpg',
        items: [
          {
            title: 'Twitter',
            url: 'twitter.com',
          },
          {
            title: 'GitHub',
            url: 'github.com',
          },
        ],
      },
      myFooter: {
        copyrightText: 'Copyright © BML landing 2016. All Rights Reserved',
        items: [
          {
            title: 'Домой',
            url: '#top',
          },
          {
            title: 'О нас',
            url: '#about',
          },
          {
            title: 'Услуги',
            url: '#services',
          },
        ],
      },
    },
    blocks: [
      {
        uuid: 'tko',
        type: 'LBlockNavbar',
        view: 'LBlockNavbarV1',
      },
      {
        uuid: 'hello',
        type: 'LBlockContentSection',
        view: 'LBlockContentSectionV1',
      },
      {
        uuid: 'hellov2',
        type: 'LBlockContentSection',
        view: 'LBlockContentSectionV2',
      },
      {
        uuid: 'hello2323',
        type: 'LBlockContentSection',
        view: 'LBlockContentSectionV1',
      },
      {
        uuid: 'ctaMyBad',
        type: 'LBlockCTA',
        view: 'LBlockCTAV1',
      },
      {
        uuid: 'myFooter',
        type: 'LBlockFooter',
        view: 'LBlockFooterV1',
      },
    ]
  }

  def site_landing_component(landing)
    react_component 'LPage', DATA
  rescue => err
    err.message
  end

  def editor_component
    react_component 'LPage', DATA
  rescue => err
    err.message
  end
end
