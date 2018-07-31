Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36751 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbeGaPpg (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 31 Jul 2018 11:45:36 -0400
Subject: Re: [PATCH v2] watchdog: add driver for the MEN 16z069 IP-Core
To: Johannes Thumshirn <jthumshirn@suse.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        mmoese@suse.de
References: <20180716072510.6939-1-jthumshirn@suse.de>
 <20180731135740.yfk7k2jy2f4magbo@linux-x5ow.site>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <10ed6a6c-4218-c166-def6-51be43e28b27@roeck-us.net>
Date: Tue, 31 Jul 2018 07:05:04 -0700
MIME-Version: 1.0
In-Reply-To: <20180731135740.yfk7k2jy2f4magbo@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/31/2018 06:57 AM, Johannes Thumshirn wrote:
> On Mon, Jul 16, 2018 at 09:25:10AM +0200, Johannes Thumshirn wrote:
>> Add a driver for the MEN 16z069 Watchdog and Reset Controller IP-Core.
>>
>> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> 
> Wim,
> Any comments about this driver? The merge window is about to open and
> I haven't heard any statement from you if you want to take it for
> 4.19.
> 

Wim,

This applies to the other watchdog patches I have lined up for v4.19.
Any chance for you to pull those into your tree to avoid missing the
commit window ?

Thanks,
Guenter
