Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:46233 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754541AbcI1Vv3 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 28 Sep 2016 17:51:29 -0400
Subject: Re: [PATCH -next] watchdog: wdat_wdt: Fix warning for using 0 as NULL
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wei Yongjun <weiyj.lk@gmail.com>
References: <1475073895-10369-1-git-send-email-weiyj.lk@gmail.com>
 <20160928145000.GC1218@lahna.fi.intel.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-watchdog@vger.kernel.org
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Message-ID: <306b9952-b386-99fe-147e-a2030f51d314@intel.com>
Date: Wed, 28 Sep 2016 23:51:24 +0200
MIME-Version: 1.0
In-Reply-To: <20160928145000.GC1218@lahna.fi.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 9/28/2016 4:50 PM, Mika Westerberg wrote:
> On Wed, Sep 28, 2016 at 02:44:55PM +0000, Wei Yongjun wrote:
>> From: Wei Yongjun <weiyongjun1@huawei.com>
>>
>> Fixes the following sparse warnings:
>>
>> drivers/watchdog/wdat_wdt.c:210:66: warning: Using plain integer as NULL pointer
>> drivers/watchdog/wdat_wdt.c:235:66: warning: Using plain integer as NULL pointer
>>
>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> Good catch!
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> (I should run sparse more often).

Applied (with tags).

Thanks,

Rafael


