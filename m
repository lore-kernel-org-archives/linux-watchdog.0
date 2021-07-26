Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFD0C4338F
	for <linux-watchdog@archiver.kernel.org>; Mon, 26 Jul 2021 12:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B1AE60F55
	for <linux-watchdog@archiver.kernel.org>; Mon, 26 Jul 2021 12:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbhGZL6m (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 26 Jul 2021 07:58:42 -0400
Received: from goliath.siemens.de ([192.35.17.28]:44724 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbhGZL6m (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 26 Jul 2021 07:58:42 -0400
X-Greylist: delayed 2075 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jul 2021 07:58:41 EDT
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 16QC4Iac011365
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 14:04:18 +0200
Received: from [139.22.37.28] ([139.22.37.28])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 16QC4HQP009313;
        Mon, 26 Jul 2021 14:04:18 +0200
Subject: Re: [PATCH] watchdog: iTCO_wdt: Fix detection of SMI-off case
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christian Storm <christian.storm@siemens.com>,
        =?UTF-8?Q?Mantas_Mikul=c4=97nas?= <grawity@gmail.com>
References: <d84f8e06-f646-8b43-d063-fb11f4827044@siemens.com>
 <CAHp75VfCydLguFX=MSoAQ_gayra5ovuwLxcY7m_pHiafvB7b5w@mail.gmail.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c1c15112-b102-570b-1432-568ca219ccf9@siemens.com>
Date:   Mon, 26 Jul 2021 14:04:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfCydLguFX=MSoAQ_gayra5ovuwLxcY7m_pHiafvB7b5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 26.07.21 14:01, Andy Shevchenko wrote:
> On Mon, Jul 26, 2021 at 2:46 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Obviously, the test needs to run against the register content, not its
>> address.
>>
>> Fixes: cb011044e34c ("watchdog: iTCO_wdt: Account for rebooting on second timeout")
>> Reported-by: Mantas Mikulėnas <grawity@gmail.com>
> 
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Missed SoB of the submitter (hint: configure your Git to make sure
> that submitter and author are the same in terms of name-email).

The signed off is there. Not sure what you are referring to.

> 
> ...
> 
>>         if (p->smi_res &&
>> -           (SMI_EN(p) & (TCO_EN | GBL_SMI_EN)) != (TCO_EN | GBL_SMI_EN))
>> +           (inl(SMI_EN(p)) & (TCO_EN | GBL_SMI_EN)) != (TCO_EN | GBL_SMI_EN))
>>                 tmrval /= 2;
> 
> There are so many parentheses, perhaps
> 
> #define TCO_GBL_SMI_EN   (TCO_EN | GBL_SMI_EN)
> ...
>        if (p->smi_res &&
>            (inl(SMI_EN(p)) & TCO_GBL_SMI_EN) != TCO_GBL_SMI_EN)
>                tmrval /= 2;
> 
> ?
> 

Let's focus on the regression fix (and you could have mentioned that on
the original patch already).

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
