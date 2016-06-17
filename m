Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from basicbox7.server-home.net ([195.137.212.29]:42833 "EHLO
	basicbox7.server-home.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085AbcFQK4I (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 17 Jun 2016 06:56:08 -0400
Subject: Re: [PATCH v5 2/4] gpio: Allow PC/104 devices on X86_64
To: Greg KH <gregkh@linuxfoundation.org>,
	William Breathitt Gray <vilhelm.gray@gmail.com>
References: <cover.1464380034.git.vilhelm.gray@gmail.com>
 <61880bededb77bbc3ea3422e48ce717d2a2ff489.1464380034.git.vilhelm.gray@gmail.com>
 <CACRpkdaOzZ1DvEUKtomBU=GH1kYfjKJjUfM-=45PhdzZA=dPgg@mail.gmail.com>
 <20160531112251.GA5674@sophia> <20160531152541.GB13304@kroah.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
	"linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-watchdog@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Guenter Roeck <linux@roeck-us.net>,
	Alexandre Courbot <gnurou@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Message-ID: <057d8c0b-074c-609a-35da-5a01f07b6d31@leemhuis.info>
Date: Fri, 17 Jun 2016 12:47:14 +0200
MIME-Version: 1.0
In-Reply-To: <20160531152541.GB13304@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 31.05.2016 17:25, Greg KH wrote:
> On Tue, May 31, 2016 at 07:23:06AM -0400, William Breathitt Gray wrot=
e:
>> On Tue, May 31, 2016 at 10:41:49AM +0200, Linus Walleij wrote:
>>> On Sat, May 28, 2016 at 12:08 AM, William Breathitt Gray
>>> <vilhelm.gray@gmail.com> wrote:
>>>> With the introduction of the ISA_BUS_API Kconfig option, ISA-style
>>>> drivers may be built for X86_64 architectures. This patch changes =
the
>>>> ISA Kconfig option dependency of the PC/104 drivers to ISA_BUS_API=
, thus
>>>> allowing them to build for X86_64 as they are expected to.
> [=E2=80=A6]
>> Greg K-H,
>>
>> Would you be able to pick up this entire patchset via driver-core; I
>> figure that tree is the most appropriate to receive any core ISA bus
>> driver changes (unless you see a more fitting path to take).
> [=E2=80=A6]
> Yes, I can take this through the driver core tree as that's where the
> original series came from...

Was this series merged or did it fell through the cracks? I currently
assume the latter, as I can't see it in neither mainline nor linux-next
(but maybe I'm missing something). Just wondering, because I have this
issue on my regression list for 4.7.

=46or the whole context see:
http://thread.gmane.org/gmane.linux.kernel.gpio/17016/

Sincerely, your regression tracker for Linux 4.7 (http://bit.ly/28JRmJo=
)
 Thorsten
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
