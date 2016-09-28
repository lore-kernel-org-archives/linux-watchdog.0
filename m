Return-path: <mika.westerberg@linux.intel.com>
Date: Wed, 28 Sep 2016 17:59:06 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Wei Yongjun <weiyongjun1@huawei.com>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH -next] watchdog: wdat_wdt: fix return value check in
 wdat_wdt_probe()
Message-ID: <20160928145906.GD1218@lahna.fi.intel.com>
References: <1475074286-13834-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475074286-13834-1-git-send-email-weiyj.lk@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Sep 28, 2016 at 02:51:26PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> In case of error, the function devm_ioremap_resource() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
