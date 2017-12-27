Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:3226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750998AbdL0Jgl (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 27 Dec 2017 04:36:41 -0500
Subject: Re: [v3,21/27] watchdog: replace devm_ioremap_nocache with
 devm_ioremap
To: Guenter Roeck <linux@roeck-us.net>
References: <1514026897-33581-1-git-send-email-xieyisheng1@huawei.com>
 <20171226172831.GA23118@roeck-us.net>
CC: <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <ysxie@foxmail.com>, Wim Van Sebroeck <wim@iguana.be>,
        <linux-watchdog@vger.kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <30d0f7f4-8f93-de23-83b7-72a9c8d4a47f@huawei.com>
Date: Wed, 27 Dec 2017 17:36:01 +0800
MIME-Version: 1.0
In-Reply-To: <20171226172831.GA23118@roeck-us.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

On 2017/12/27 1:28, Guenter Roeck wrote:
> On Sat, Dec 23, 2017 at 07:01:37PM +0800, Yisheng Xie wrote:
>> > Default ioremap is ioremap_nocache, so devm_ioremap has the same
>> > function with devm_ioremap_nocache, which can just be killed to
>> > save the size of devres.o
>> > 
>> > This patch is to use use devm_ioremap instead of devm_ioremap_nocache,
>> > which should not have any function change but prepare for killing
>> > devm_ioremap_nocache.
>> > 
> I don't have issues with the patch itself - on mips, the definitions
> _are_ the same - but with the description. It is not universally correct
> that the definitions are the same. Please update and resubmit.
> 

Right, there are 4 archs have different meaning of ioremap. And presently, I
still do not know why.

For this patch itself, maybe I can update and resubmit.

Thanks and Merry Christmas.
Yisheng

> Guenter
> 

