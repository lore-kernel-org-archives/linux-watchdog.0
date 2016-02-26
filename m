Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:45052 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932099AbcBZIWC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 26 Feb 2016 03:22:02 -0500
Date: Fri, 26 Feb 2016 09:21:59 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Mark Brown <broonie@kernel.org>,
	Gregory CLEMENT <gregory.clement@free-electrons.com>,
	Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	kernel-build-reports@lists.linaro.org,
	linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: next-20160225 build: 2 failures 44 warnings (next-20160225)
Message-ID: <20160226092159.2f7ef3c7@free-electrons.com>
In-Reply-To: <56D001BE.2090209@roeck-us.net>
References: <E1aYsmb-0006qb-76@optimist>
	<20160226030949.GL18327@sirena.org.uk>
	<56D001BE.2090209@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Guenter,

On Thu, 25 Feb 2016 23:41:50 -0800, Guenter Roeck wrote:

> > also caused by b4f596b19624 (arm64: add mvebu architecture entry) which
> > enables MVBEU on arm64, the commit was present for a little while and
> > the error cropped up but didn't get reported due to other things masking
> > it.  atomic_io_modify() is only available on ARM, I'm unsure if this
> > needs a driver change or if the driver is just specific to older
> > hardware anyway.  The code is only used in the init path accessing what
> > look to be device specific registers so I'm not 100% clear why it
> > specifically needs to be an atomic modify.
> >
> Thierry already submitted a patch yesterday to restrict the driver to only
> build on ARM. We can revisit if/when the driver is needed on ARM64.

Ah, good, thanks. It isn't clear yet whether the driver will be needed
on ARM64 for the Marvell platforms. For Armada 7K/8K, there is a SBSA
compliant watchdog. For Armada 3700, I have only briefly looked, but it
seems to be a different IP than the one used on the 32 bits SoCs.

Thanks Thierry for fixing the issue!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
