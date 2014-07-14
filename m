Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:49280 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbaGNJSi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 Jul 2014 05:18:38 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for 'devm_ioremap_resource'
From: Chen Gang <gang.chen.5i5j@gmail.com>
In-Reply-To: <53C39B66.4060500@nod.at>
Date: Mon, 14 Jul 2014 17:22:39 +0800
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dmitry.torokhov@gmail.com, linux-iio@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, teg@jklm.no,
	Thierry Reding <thierry.reding@gmail.com>,
	Lennox Wu <lennox.wu@gmail.com>,
	Chen Gang <gang.chen.5i5j@gmail.com>,
	Marek Vasut <marex@denx.de>,
	Liqin Chen <liqin.linux@gmail.com>, msalter@redhat.com,
	linux-pwm@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-watchdog@vger.kernel.org, linux-input@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	knaack.h@gmx.de, Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Mischa.Jonker@synopsys.com, jic23@kernel.org
Content-Transfer-Encoding: QUOTED-PRINTABLE
Message-Id: <5A40E1FC-CA61-4AFF-B205-4BAC175AA7AC@gmail.com>
References: <201407130545.23004.marex@denx.de> <CAF0htA60juBVkPo2HQKMDGcEr-wRzRVL_6JgHAa+7WVE_E8M0Q@mail.gmail.com> <53C25551.1050909@nod.at> <53C288F0.3070001@metafoo.de> <53C28C4A.70907@nod.at> <53C29015.5070607@metafoo.de> <53C291C8.6050303@nod.at> <53C296C2.30304@metafoo.de> <20140713192202.GA19090@kroah.com> <53C2DF12.6040507@nod.at> <20140713201753.GA29955@kroah.com> <53C39569.9020802@nod.at> <53C3994C.1010309@metafoo.de> <53C39B66.4060500@nod.at>
To: Richard Weinberger <richard@nod.at>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


=E5=9C=A8 2014=E5=B9=B47=E6=9C=8814=E6=97=A5=EF=BC=8C=E4=B8=8B=E5=8D=88=
4:57=EF=BC=8CRichard Weinberger <richard@nod.at> =E5=86=99=E9=81=93=EF=BC=
=9A

> Am 14.07.2014 10:48, schrieb Lars-Peter Clausen:
>> On 07/14/2014 10:31 AM, Richard Weinberger wrote:
>>> Am 13.07.2014 22:17, schrieb Greg Kroah-Hartman:
>>>> On Sun, Jul 13, 2014 at 09:33:38PM +0200, Richard Weinberger wrote=
:
>>>>> Maybe we could add COMPILE_TEST to the version string too?
>>>>> Just to detect such kernels fast in user bug reports...
>>>>=20
>>>> What kind of bug report are you going to get?
>>>=20
>>> User manages to enable CONFIG_FOO by selecting COMPILE_TEST and
>>> complains that it does not work. :)
>>=20
>> These drivers are typically drivers for some SoC peripheral and the =
device will simply physically not exist on a platform that does not pro=
vide HAS_IOMEM. This is not really any
>> different from making the driver selectable via COMPILE_TEST for any=
 other platform. To hit the issue you'd have to instantiate a device dr=
iver instance for a device that
>> physically does not exist. This will always result in a failure.
>=20
> Okay, you have convinced me. :)
>=20

OK, thank all of you, and I shall send the related patch for it.=20

I will try to finish it within this week.

Thanks.
=E2=80=94
Chen Gang
Open, share, and attitude like air, water, and life which God blessed.-=
-
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
