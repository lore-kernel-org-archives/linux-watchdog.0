Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3913C433B4
	for <linux-watchdog@archiver.kernel.org>; Tue, 11 May 2021 02:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FADF61400
	for <linux-watchdog@archiver.kernel.org>; Tue, 11 May 2021 02:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEKCus (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 10 May 2021 22:50:48 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2050 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhEKCus (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 10 May 2021 22:50:48 -0400
Received: from dggeml751-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FfMjL2T8NzWglk;
        Tue, 11 May 2021 10:45:26 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggeml751-chm.china.huawei.com (10.1.199.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 11 May 2021 10:49:40 +0800
Received: from [10.67.77.175] (10.67.77.175) by dggpeml500023.china.huawei.com
 (7.185.36.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 11 May
 2021 10:49:39 +0800
Subject: Re: [PATCH] watchdog: sbsa: Support architecture version 1
To:     Guenter Roeck <linux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>
CC:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Al Stone <al.stone@linaro.org>,
        Jianchao Hu <hujianchao@hisilicon.com>,
        Huiqiang Wang <wanghuiqiang@huawei.com>
References: <1620618117-20135-1-git-send-email-zhangshaokun@hisilicon.com>
 <87833e5a-978a-aac5-fc4b-1a922864066b@roeck-us.net>
 <bf9e1b65-119b-d027-fc3d-8491cbc38cde@hisilicon.com>
 <669e1175-2eee-6c4b-8524-c672626022b6@roeck-us.net>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <fb880396-4c30-78ff-2c1f-62ad4fef935f@hisilicon.com>
Date:   Tue, 11 May 2021 10:49:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <669e1175-2eee-6c4b-8524-c672626022b6@roeck-us.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.77.175]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Hi Guenter,

On 2021/5/10 21:16, Guenter Roeck wrote:
> On 5/10/21 1:25 AM, Shaokun Zhang wrote:
>> Hi Guenter,
>>
>> On 2021/5/10 12:25, Guenter Roeck wrote:
>>> On 5/9/21 8:41 PM, Shaokun Zhang wrote:
>>>> Arm Base System Architecture 1.0[1] has introduced watchdog
>>>> revision 1 that increases the length the watchdog offset
>>>
>>> Is that how they call the watchdog count register ?
>>>
>>
>> I think yes.
>>
>>> Also, doesn't that mean that the maximum timeout supported
>>> by the hardware is now larger ?
>>
>> No, maximum timeout is the same. But the clock can be higher than
>> before. For Armv8.6, The frequency of CNTFRQ_EL0 is standardized to
>> a frequency of 1GHz which will set gwdt->clk. If the timeout is
>> greater than 4(second), the 32-bit counter(WOR) is not enough.
>>
> 
> The maximuma timeout is limited with
> 
> wdd->max_hw_heartbeat_ms = U32_MAX / gwdt->clk * 1000;
> > You did not update that calculation. That means that the maximuma
> timeout is still U32_MAX / gwdt->clk * 1000, which still fits
> into 32 bit.

Correct, I will fix this in next version.

> 
> Please correct me if I am missing something.
> 

My bad, you are right. The maximum timeout shall be
0xFFFF.FFFF.FFFF / 1000.000.000(1GHz) which is larger than before
0xFFFF.FFFF / 100.000.000(100MHz) by the hardware.

Can I do like this, after the version is got and check the version?
        sbsa_gwdt_set_timeout(wdd, wdd->timeout);
+       sbsa_gwdt_get_version(wdd);
+       if (wdd->version > 0)
+               wdd->max_hw_heartbeat_ms = GENMASK_ULL(47, 0) / gwdt->clk * 1000;


Thanks,
Shaokun

> Guenter
> .
