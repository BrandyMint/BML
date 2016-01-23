module LandingExamples
  EXAMPLE1 = {
    regenerate_uuid: true,
    css: '
    ',
    data: {
      mr: {
        header: 'На все 100% !',
        subheader: 'Шаблон для посадочной страницы',
        backgroundImageUrl: '/assets/images/themes/t1/banner-bg.jpg',
        items: [
          {
            icon: 'twitter',
            title: 'Twitter',
            url: 'twitter.com'
          },
          {
            icon: 'github',
            title: 'GitHub',
            url: 'github.com'
          }
        ]
      },
      tko: {
        logoText: 'Лендос!',
        items: [
          {
            title: 'О нас',
            url: 'google.ru'
          },
          {
            title: 'Услуги',
            url: 'services.ru'
          }
        ]
      },
      hello: {
        headerText: 'Отдельное спасибо <br />Death to the Stock Photo !',
        leadText: 'Отдельное спасибо <a target="_blank" href="http://join.deathtothestockphoto.com/">Death to the Stock Photo</a> за предоставленные фотографии которые Вы видите в этом шаблоне. <br />Посетите их сайт и получите доступ к огрмному количеству качественных фото.',
        image: {
          url: '/assets/images/themes/t1/ipad.png',
          height: 354,
          width: 458
        }
      },
      hellov2: {
        headerText: '3D макеты на предметах<br /> от PSDCovers',
        leadText: 'Преврати свой двумерный дизайн в высококачественные, трехмерные снимки за секунды используя бесплатные экшены в Photoshop от <a target="_blank" href="http://www.psdcovers.com/">PSDCovers</a>!<br />Посетите их сайт чтобы скачать что-то восхитительное и увидить экшены в действии!',
        image: {
          url: '/assets/images/themes/t1/dog.png',
          height: 383,
          width: 458
        }
      },
      hello2323: {
        headerText: 'Шрифты Google Web и<br>иконки Font Awesome',
        leadText: 'Этот шаблон применяет \'Lato\' шрифт, часть <a target="_blank" href="http://www.google.com/fonts">библиотеки Google Web Font</a>, также как и <a target="_blank" href="http://fontawesome.io">иконки из Font Awesome</a>.',
        image: {
          url: '/assets/images/themes/t1/phones.png',
          height: 302,
          width: 458
        }
      },
      ctaMyBad: {
        text: 'Присоединяйся к нам в соцсетях!',
        backgroundImageUrl: '/assets/images/themes/t1/banner-bg.jpg',
        items: [
          {
            icon: 'twitter',
            title: 'Twitter',
            url: 'twitter.com'
          },
          {
            icon: 'github',
            title: 'GitHub',
            url: 'github.com'
          }
        ]
      },
      myFooter: {
        copyrightText: 'Copyright © BML landing 2016. All Rights Reserved',
        items: [
          {
            title: 'Домой',
            url: '#top'
          },
          {
            title: 'О нас',
            url: '#about'
          },
          {
            title: 'Услуги',
            url: '#services'
          }
        ]
      }
    },
    blocks: [
      {
        uuid: 'tko',
        type: 'LBlockNavbar',
        view: 'LBlockNavbarV1'
      },
      {
        uuid: 'mr',
        type: 'LBlockMustRead',
        view: 'LBlockMustReadV1'
      },
      {
        uuid: 'hello',
        type: 'LBlockContentSection',
        view: 'LBlockContentSectionV1'
      },
      {
        uuid: 'hellov2',
        type: 'LBlockContentSection',
        view: 'LBlockContentSectionV2'
      },
      {
        uuid: 'hello2323',
        type: 'LBlockContentSection',
        view: 'LBlockContentSectionV1'
      },
      {
        uuid: 'ctaMyBad',
        type: 'LBlockCTA',
        view: 'LBlockCTAV1'
      },
      {
        uuid: 'myFooter',
        type: 'LBlockFooter',
        view: 'LBlockFooterV1'
      }
    ]
  }

end
