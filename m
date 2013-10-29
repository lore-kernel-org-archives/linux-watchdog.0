Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:42254 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab3J2Ji6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 29 Oct 2013 05:38:58 -0400
Received: by mail-oa0-f53.google.com with SMTP id n12so4941241oag.12
        for <linux-watchdog@vger.kernel.org>; Tue, 29 Oct 2013 02:38:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20131029074646.GC19704@spo001.leaseweb.com>
References: <1380516173-6974-1-git-send-email-sachin.kamat@linaro.org>
	<20131029074646.GC19704@spo001.leaseweb.com>
Date: Tue, 29 Oct 2013 15:08:57 +0530
Message-ID: <CAK9yfHxCjdkHxJ1feo4zyQMRV82oyQPSwMRKWGGF6xqhU+HaBQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] watchdog: at91rm9200: Remove redundant of_match_ptr
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 29 October 2013 13:16, Wim Van Sebroeck <wim@iguana.be> wrote:
> Hi Sachin,
>
>> The data structure of_match_ptr() protects is always compiled in.
>> Hence of_match_ptr() is not needed.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>
> Your 3 patches concerning of_match_ptr have been added as a single patch
> to linux-watchdog-next. I also adapted the commit message with your the
> description you gave later on to Guenter.

Thanks Wim.

-- 
With warm regards,
Sachin
