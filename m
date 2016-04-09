Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:46676 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784AbcDIPws (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 9 Apr 2016 11:52:48 -0400
Date: Sat, 9 Apr 2016 16:51:31 +0100
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, gregkh@linuxfoundation.org,
	tglx@linutronix.de, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, wim@iguana.be,
	linus.walleij@linaro.org, gnurou@gmail.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 04/10] iio: stx104: Change STX104 dependency to ISA_BUS
Message-ID: <20160409165131.4d4a109b@lxorguk.ukuu.org.uk>
In-Reply-To: <20160409135050.GA10418@sophia>
References: <cover.1460040201.git.vilhelm.gray@gmail.com>
	<783be62acf68b35f3fe4785a2cedfe017624688b.1460040201.git.vilhelm.gray@gmail.com>
	<20160408004503.GB10211@roeck-us.net>
	<20160408123158.GB18202@sophia>
	<5707AF91.5010704@roeck-us.net>
	<20160408150922.GA28058@sophia>
	<20160408182801.GB7083@roeck-us.net>
	<20160408192723.GA31687@sophia>
	<20160409135814.359e24d6@lxorguk.ukuu.org.uk>
	<20160409135050.GA10418@sophia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> It looks like I'm in quite a pickle. Even if the patch for the PnPBIOS
> driver removes the errors and warnings, there may be runtime bugs in
> other drivers expecting X86_32. The only way I can see to prevent that
> is to audit all the drivers which depend on the ISA option -- a behemoth
> undertaking which would be far too impractical and error-prone for me to
> do.

I actually wouldn't worry. We've got lots of other drivers that don't
work on all the platforms they should because nobody has ever tried them
out.

At least if they compile on the different platforms people will be able
to try them. It's not making anything any worse - it used to not work and
it still doesn't work is the failure case 8)

Alan
