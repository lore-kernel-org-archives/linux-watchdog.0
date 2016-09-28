Return-path: <mika.westerberg@linux.intel.com>
Date: Wed, 28 Sep 2016 17:50:00 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Wei Yongjun <weiyongjun1@huawei.com>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH -next] watchdog: wdat_wdt: Fix warning for using 0 as NULL
Message-ID: <20160928145000.GC1218@lahna.fi.intel.com>
References: <1475073895-10369-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475073895-10369-1-git-send-email-weiyj.lk@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Sep 28, 2016 at 02:44:55PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fixes the following sparse warnings:
> 
> drivers/watchdog/wdat_wdt.c:210:66: warning: Using plain integer as NULL pointer
> drivers/watchdog/wdat_wdt.c:235:66: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Good catch!

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

(I should run sparse more often).
