Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:60725 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932322AbcHXSUe (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 24 Aug 2016 14:20:34 -0400
Subject: Re: pre-timeout again?
To: Wolfram Sang <wsa@the-dreams.de>, <linux-watchdog@vger.kernel.org>
References: <20160824123510.GB5190@katana>
CC: Guenter Roeck <linux@roeck-us.net>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <d396484c-d8c6-1212-1fde-0059cc594e3c@mentor.com>
Date: Wed, 24 Aug 2016 21:19:28 +0300
MIME-Version: 1.0
In-Reply-To: <20160824123510.GB5190@katana>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

On 08/24/2016 03:35 PM, Wolfram Sang wrote:
> Hi,
>
> I'd really like to see pretimeout support added in v4.9. Can't I just
> resend my latest series (since Vladimir's latest series had some issues
> which were already fixed in mine IIRC)? I still think this provides a
> solid ground where Vladimir could add the missing features on top. I can
> remove my copyright line, too, if that is important.

copyright is not an issue for me, the authorship is.

I'm not sure about the diff of the known issues between your and my series,
IIRC the changes you had sent one day were not reviewed thoroughly.

> It's a bit sad that I have time assigned to this task but am basically
> blocked currently. Or were there other issues I forgot?
>

It's a bit sad that two your patches were not integrated to v4.8:

   http://www.spinics.net/lists/linux-watchdog/msg09484.html

I'll spend some time this week to retest my series before sending v4.
I'm going to drop sleeping governor support like you did to simplify
the change.

--
With best wishes,
Vladimir
