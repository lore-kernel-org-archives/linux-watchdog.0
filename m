Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:39744 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755545AbaGOAey (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 Jul 2014 20:34:54 -0400
Message-ID: <53C47725.8000005@gmail.com>
Date: Tue, 15 Jul 2014 08:34:45 +0800
From: Chen Gang <gang.chen.5i5j@gmail.com>
MIME-Version: 1.0
To: Richard Weinberger <richard@nod.at>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dmitry.torokhov@gmail.com, linux-iio@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, teg@jklm.no,
	Thierry Reding <thierry.reding@gmail.com>,
	Lennox Wu <lennox.wu@gmail.com>, Marek Vasut <marex@denx.de>,
	Liqin Chen <liqin.linux@gmail.com>, msalter@redhat.com,
	linux-pwm@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-watchdog@vger.kernel.org, linux-input@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	knaack.h@gmx.de, Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Mischa.Jonker@synopsys.com, jic23@kernel.org, arnd@arndb.de,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
References: <201407130545.23004.marex@denx.de> <CAF0htA60juBVkPo2HQKMDGcEr-wRzRVL_6JgHAa+7WVE_E8M0Q@mail.gmail.com> <53C25551.1050909@nod.at> <53C288F0.3070001@metafoo.de> <53C28C4A.70907@nod.at> <53C29015.5070607@metafoo.de> <53C291C8.6050303@nod.at> <53C296C2.30304@metafoo.de> <20140713192202.GA19090@kroah.com> <53C2DF12.6040507@nod.at> <20140713201753.GA29955@kroah.com> <53C39569.9020802@nod.at> <53C3994C.1010309@metafoo.de> <53C39B66.4060500@nod.at> <5A40E1FC-CA61-4AFF-B205-4BAC175AA7AC@gmail.com>
In-Reply-To: <5A40E1FC-CA61-4AFF-B205-4BAC175AA7AC@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/14/2014 05:22 PM, Chen Gang wrote:
>=20
> =E5=9C=A8 2014=E5=B9=B47=E6=9C=8814=E6=97=A5=EF=BC=8C=E4=B8=8B=E5=8D=88=
4:57=EF=BC=8CRichard Weinberger <richard@nod.at> =E5=86=99=E9=81=93=EF=BC=
=9A
>=20
>> Am 14.07.2014 10:48, schrieb Lars-Peter Clausen:
>>> On 07/14/2014 10:31 AM, Richard Weinberger wrote:
>>>> Am 13.07.2014 22:17, schrieb Greg Kroah-Hartman:
>>>>> On Sun, Jul 13, 2014 at 09:33:38PM +0200, Richard Weinberger wrot=
e:
>>>>>> Maybe we could add COMPILE_TEST to the version string too?
>>>>>> Just to detect such kernels fast in user bug reports...
>>>>>
>>>>> What kind of bug report are you going to get?
>>>>
>>>> User manages to enable CONFIG_FOO by selecting COMPILE_TEST and
>>>> complains that it does not work. :)
>>>
>>> These drivers are typically drivers for some SoC peripheral and the=
 device will simply physically not exist on a platform that does not pr=
ovide HAS_IOMEM. This is not really any
>>> different from making the driver selectable via COMPILE_TEST for an=
y other platform. To hit the issue you'd have to instantiate a device d=
river instance for a device that
>>> physically does not exist. This will always result in a failure.
>>
>> Okay, you have convinced me. :)
>>

After search the history patches, I found one related patch which made
by myself (when I am in Asianux):

  "https://lkml.org/lkml/2013/7/1/641"

=46or me, it is a long discussion, and forced many members have to join
in. Please help check again.

Thanks.

>=20
> OK, thank all of you, and I shall send the related patch for it.=20
>=20
> I will try to finish it within this week.
>=20

--=20
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
