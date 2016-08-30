Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:47924 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755670AbcH3QL5 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 30 Aug 2016 12:11:57 -0400
Subject: Re: [PATCH v2] watchdog: softdog: implement pretimeout support
To: Wolfram Sang <wsa@the-dreams.de>, <linux-watchdog@vger.kernel.org>
References: <20160830150306.2254-1-wsa@the-dreams.de>
CC: <linux-renesas-soc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <ad860021-64bd-b816-c091-abe649aa5518@mentor.com>
Date: Tue, 30 Aug 2016 19:11:52 +0300
MIME-Version: 1.0
In-Reply-To: <20160830150306.2254-1-wsa@the-dreams.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

On 08/30/2016 06:03 PM, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Give devices which do not have hardware support for pretimeout at least a
> software version of it.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Change since v1: added 'else' block in softdog_ping(), to actually
> disable the timer when pretimeout value got cleared.
>
> Depends on the V4 pretimeout series from Vladimir.
>
> Vladimir: Maybe you could add this patch to the next revision of your
> pretimeout series? Then people have something to play around with
> right away.

I'll add it to the series, and most probably I'll add a pretimeout
support to the iMX watchdog driver.

The v5 series will be published today tonight or tomorrow.

--
Best wishes,
Vladimir
