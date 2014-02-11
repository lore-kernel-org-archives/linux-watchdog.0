Return-Path: <mika.westerberg@linux.intel.com>
Date: Tue, 11 Feb 2014 12:09:06 +0200
From: 'Mika Westerberg' <mika.westerberg@linux.intel.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Wim Van Sebroeck' <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>
Subject: Re: [PATCH 7/8] watchdog: ts72xx_wdt: Remove unnecessary OOM messages
Message-ID: <20140211100906.GB18029@intel.com>
References: <000101cf26f5$06c21760$14464620$%han@samsung.com>
 <000801cf26f6$2c18d930$844a8b90$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000801cf26f6$2c18d930$844a8b90$%han@samsung.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Feb 11, 2014 at 03:54:56PM +0900, Jingoo Han wrote:
> The site-specific OOM messages are unnecessary, because they
> duplicate the MM subsystem generic OOM message.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
