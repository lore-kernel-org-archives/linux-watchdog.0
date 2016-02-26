Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34259 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbcBZHl4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 26 Feb 2016 02:41:56 -0500
Subject: Re: next-20160225 build: 2 failures 44 warnings (next-20160225)
To: Mark Brown <broonie@kernel.org>,
	Gregory CLEMENT <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
	Wim Van Sebroeck <wim@iguana.be>
References: <E1aYsmb-0006qb-76@optimist>
 <20160226030949.GL18327@sirena.org.uk>
Cc: kernel-build-reports@lists.linaro.org,
	linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56D001BE.2090209@roeck-us.net>
Date: Thu, 25 Feb 2016 23:41:50 -0800
MIME-Version: 1.0
In-Reply-To: <20160226030949.GL18327@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Mark,

On 02/25/2016 07:09 PM, Mark Brown wrote:
> On Thu, Feb 25, 2016 at 10:04:29AM +0000, Build bot for Mark Brown wrote:
>
> Today's -next fails to build an arm64 allmodconfig due to:
>
>> 	arm64-allmodconfig
>> ../drivers/watchdog/orion_wdt.c:109:2: error: implicit declaration of function 'atomic_io_modify' [-Werror=implicit-function-declaration]
>
> also caused by b4f596b19624 (arm64: add mvebu architecture entry) which
> enables MVBEU on arm64, the commit was present for a little while and
> the error cropped up but didn't get reported due to other things masking
> it.  atomic_io_modify() is only available on ARM, I'm unsure if this
> needs a driver change or if the driver is just specific to older
> hardware anyway.  The code is only used in the init path accessing what
> look to be device specific registers so I'm not 100% clear why it
> specifically needs to be an atomic modify.
>
Thierry already submitted a patch yesterday to restrict the driver to only
build on ARM. We can revisit if/when the driver is needed on ARM64.

Guenter

