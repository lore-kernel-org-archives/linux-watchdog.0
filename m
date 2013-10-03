Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from [207.46.163.24] ([207.46.163.24]:6149 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753551Ab3JCJOa (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Oct 2013 05:14:30 -0400
Date: Thu, 3 Oct 2013 11:13:05 +0200
From: Michal Simek <michal.simek@xilinx.com>
MIME-Version: 1.0
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
CC: Michal Simek <michal.simek@xilinx.com>,
	<linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	Dan Williams <dan.j.williams@intel.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Chris Ball <cjb@laptop.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.cz>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Andrew Morton <akpm@linux-foundation.org>,
	"zhangwei(Jovi)" <jovi.zhangwei@huawei.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-input@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, <linux-spi@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-fbdev@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH] amba: Ensure drvdata is NULL
References: <1b2479137287fa8dfda3089ca0cb9fba8c4b1f1d.1380524337.git.michal.simek@xilinx.com> <20131002202521.GU12758@n2100.arm.linux.org.uk>
In-Reply-To: <20131002202521.GU12758@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <d5a0aab9-f023-4464-b4a1-f7055e6c82d5@CO9EHSMHS010.ehs.local>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/02/2013 10:25 PM, Russell King - ARM Linux wrote:
> On Mon, Sep 30, 2013 at 08:59:06AM +0200, Michal Simek wrote:
>> This patch is inpired by the patch for drvdata
>> "device-core: Ensure drvdata = NULL when no driver is bound"
>> (sha1: 0998d0631001288a5974afc0b2a5f568bcdecb4d)
>>
>> Also it fixes all occurences in drivers.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>> This patch has been sent as RFC in this thread.
>> http://lkml.org/lkml/2013/9/4/393
> 
> Why not have the driver core do this?  Then it gets applied to all bus
> types uniformly.

ok - I have checked that path and it should be already done
in really_probe function which calls amba_probe() and then driver probe function.

It means that the patch should contain just "amba_set_drvdata(dev, NULL);"
removal and not touching bus.c file.

Thanks,
Michal


