Return-path: <matt@console-pimps.org>
Date: Wed, 29 Jul 2015 17:39:53 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
To: Lee Jones <lee.jones@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Zha Qipeng <qipeng.zha@intel.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/3] iTCO_wdt: Expose watchdog properties using
 platform data
Message-ID: <20150729163953.GI2773@codeblueprint.co.uk>
References: <1438171844-24861-1-git-send-email-matt@codeblueprint.co.uk>
 <1438171844-24861-2-git-send-email-matt@codeblueprint.co.uk>
 <20150729153556.GC9319@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150729153556.GC9319@x1>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, 29 Jul, at 04:35:56PM, Lee Jones wrote:
> 
> For my own reference (I assume this will go through the MFD tree):
>   Acked-by: Lee Jones <lee.jones@linaro.org>

Great, thanks Lee!

I've no strong opinion on which tree these 3 patches go through but at
the very least patches 1 and 2 need to go through the same tree to avoid
build breakage (since PATCH 1 introduces 'struct itco_wdt_platform_data'
which is used in PATCH 2).

For reference, the other patches are here,

  https://lkml.kernel.org/r/1438171844-24861-3-git-send-email-matt@codeblueprint.co.uk
  https://lkml.kernel.org/r/1438171844-24861-4-git-send-email-matt@codeblueprint.co.uk

-- 
Matt Fleming, Intel Open Source Technology Center
