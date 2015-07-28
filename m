Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35025 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbbG1JRc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Jul 2015 05:17:32 -0400
Received: by wibxm9 with SMTP id xm9so147693070wib.0
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2015 02:17:31 -0700 (PDT)
Date: Tue, 28 Jul 2015 10:17:28 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>
Subject: Re: [PATCH 4/5] iTCO_wdt: fixup for the header
Message-ID: <20150728091728.GC2492@codeblueprint.co.uk>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
 <1438004292-16382-5-git-send-email-matt@codeblueprint.co.uk>
 <55B63C8B.80100@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55B63C8B.80100@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 27 Jul, at 07:13:31AM, Guenter Roeck wrote:
> On 07/27/2015 06:38 AM, Matt Fleming wrote:
> >From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> >Prevent nested inclusion of the header.
> >
> >Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >Cc: Wim Van Sebroeck <wim@iguana.be>
> >Signed-off-by: Matt Fleming <matt.fleming@intel.com>
> 
> Should be merged into patch 1.

OK, will do.

-- 
Matt Fleming, Intel Open Source Technology Center
