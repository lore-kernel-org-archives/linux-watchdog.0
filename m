Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:51552 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab3JBQIP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Oct 2013 12:08:15 -0400
Received: by mail-oa0-f53.google.com with SMTP id i7so990852oag.26
        for <linux-watchdog@vger.kernel.org>; Wed, 02 Oct 2013 09:08:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20131002151347.GA14121@roeck-us.net>
References: <1380516173-6974-1-git-send-email-sachin.kamat@linaro.org>
	<20131001204842.GA20057@roeck-us.net>
	<CAK9yfHz4vPbiSq+85OegDN4bJ-UWy6RFxhi+4HJnWoCBMxpUNA@mail.gmail.com>
	<20131002151347.GA14121@roeck-us.net>
Date: Wed, 2 Oct 2013 21:38:14 +0530
Message-ID: <CAK9yfHwdOOoZb1bubxB7n2zdDiMS60MKv_MwR=UT7N6Cj3bJuw@mail.gmail.com>
Subject: Re: [1/3] watchdog: at91rm9200: Remove redundant of_match_ptr
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 2 October 2013 20:43, Guenter Roeck <linux@roeck-us.net> wrote:
> On Wed, Oct 02, 2013 at 12:13:04PM +0530, Sachin Kamat wrote:
>> Hi  Guenter,
>>
>> On 2 October 2013 02:18, Guenter Roeck <linux@roeck-us.net> wrote:
>> > On Mon, Sep 30, 2013 at 12:42:51PM -0000, Sachin Kamat wrote:
>> >> The data structure of_match_ptr() protects is always compiled in.
>> >> Hence of_match_ptr() is not needed.
>> >>
>> >> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> >>
>> >
>> > Hi Sachin,
>> >
>> > I understand that the driver doesn't currently support to be built as module,
>> > so of_match_ptr() is not really necessary. But unless I am missing something,
>> > here isn't anything wrong with it either, not does it hurt to have it in place.
>> >
>> > So what is the benefit of this series ?
>>
>> of_match_ptr() is a macro used to avoid undefined reference error if
>> CONFIG_OF is used to selectively compile in or out the
>> data structure. It is defined as follows:
>>
>> #ifdef CONFIG_OF
>> #define of_match_ptr(ptr) ptr
>> #else
>> #define of_match_ptr(ptr) NULL
>> #endif
>>
>> In the case of this series, none of the drivers use CONFIG_OF macro to
>> compile out the data structure (i.e., the data structure is always
>> defined).
>> Hence the use of of_match_ptr() does not make any sense. Thus removing
>> it to make the code look simpler for readability.
>>
>> Hope this clarifies.
>
> Ok, I'll accept that.
>
> Acked-by: Guenter Roeck <linux@roeck-us.net>

 Thanks Guenter.

-- 
With warm regards,
Sachin
