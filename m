Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37167 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbbG1JRp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Jul 2015 05:17:45 -0400
Received: by wibud3 with SMTP id ud3so150046330wib.0
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2015 02:17:44 -0700 (PDT)
Date: Tue, 28 Jul 2015 10:17:42 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>
Subject: Re: [PATCH 5/5] i2c-i801: fixup regarding watchdog timer
Message-ID: <20150728091742.GD2492@codeblueprint.co.uk>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
 <1438004292-16382-6-git-send-email-matt@codeblueprint.co.uk>
 <55B63CB0.7000302@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55B63CB0.7000302@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 27 Jul, at 07:14:08AM, Guenter Roeck wrote:
> On 07/27/2015 06:38 AM, Matt Fleming wrote:
> >From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> >Change &array[0] to array since it's the same.
> >
> >It fixes 80 character limit warning as well.
> >
> >Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >Cc: Jean Delvare <jdelvare@suse.com>
> >Cc: Wolfram Sang <wsa@the-dreams.de>
> >Signed-off-by: Matt Fleming <matt.fleming@intel.com>
> 
> Should be merged into patch 2.

OK, will do.

-- 
Matt Fleming, Intel Open Source Technology Center
