Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2329C433ED
	for <linux-watchdog@archiver.kernel.org>; Sun, 25 Apr 2021 08:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACAB261481
	for <linux-watchdog@archiver.kernel.org>; Sun, 25 Apr 2021 08:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhDYIGl (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 25 Apr 2021 04:06:41 -0400
Received: from jptosegrel01.sonyericsson.com ([124.215.201.71]:15853 "EHLO
        JPTOSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229485AbhDYIGk (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 25 Apr 2021 04:06:40 -0400
Subject: Re: [RFC PATCH] watchdog: Adding softwatchdog
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Shakeel Butt <shakeelb@google.com>
References: <20210424102555.28203-1-peter.enderborg@sony.com>
 <20210424102555.28203-2-peter.enderborg@sony.com>
 <d5db5606-f074-6d0e-2316-8ff41af25cfd@roeck-us.net>
 <844e3ecb-62c3-856a-7273-e22eee35e80f@i-love.sakura.ne.jp>
 <d2be282c-f39a-dc85-817b-94a40efeb232@sony.com>
 <d76447a5-4580-eb4e-e6d9-d675ca016462@i-love.sakura.ne.jp>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <a029b819-ae42-8d3f-c600-501f3407dbc2@sony.com>
Date:   Sun, 25 Apr 2021 10:05:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d76447a5-4580-eb4e-e6d9-d675ca016462@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=DLnxHBFb c=1 sm=1 tr=0 a=9drRLWArJOlETflmpfiyCA==:117 a=IkcTkHD0fZMA:10 a=3YhXtTcJ-WEA:10 a=zMbtgt_OlYy5lv0L-mkA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org


> By the way, there already is "Software Watchdog" ( drivers/watchdog/softdog.c )
> which some people might call it "soft watchdog". It is very confusing to name
> your module as "softwatchdog". Please find a different name.
>
Would puppydog do?

