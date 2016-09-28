Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63848 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754326AbcI1Vuz (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 28 Sep 2016 17:50:55 -0400
Subject: Re: [PATCH -next] watchdog: wdat_wdt: fix return value check in
 wdat_wdt_probe()
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wei Yongjun <weiyj.lk@gmail.com>
References: <1475074286-13834-1-git-send-email-weiyj.lk@gmail.com>
 <20160928145906.GD1218@lahna.fi.intel.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-watchdog@vger.kernel.org
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Message-ID: <05841e35-ac1d-eaba-12cf-c813dac1f9e7@intel.com>
Date: Wed, 28 Sep 2016 23:50:49 +0200
MIME-Version: 1.0
In-Reply-To: <20160928145906.GD1218@lahna.fi.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 9/28/2016 4:59 PM, Mika Westerberg wrote:
> On Wed, Sep 28, 2016 at 02:51:26PM +0000, Wei Yongjun wrote:
>> From: Wei Yongjun <weiyongjun1@huawei.com>
>>
>> In case of error, the function devm_ioremap_resource() returns ERR_PTR()
>> and never returns NULL. The NULL test in the return value check should
>> be replaced with IS_ERR().
>>
>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied (with tags).


Thanks,

Rafael


