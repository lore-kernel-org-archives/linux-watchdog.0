Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41422 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932088AbeB0PDb (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 27 Feb 2018 10:03:31 -0500
Subject: Re: [PATCH] watchdog: renesas_wdt: adapt timer setup to recommended
 procedure
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
References: <20180226214905.24516-1-wsa+renesas@sang-engineering.com>
 <20180226223853.GC5924@roeck-us.net>
 <20180227130058.pmgo33zjvbxwmlad@ninjato>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <86da4e12-0d0c-c07a-eecd-76466f713da1@roeck-us.net>
Date: Tue, 27 Feb 2018 07:03:29 -0800
MIME-Version: 1.0
In-Reply-To: <20180227130058.pmgo33zjvbxwmlad@ninjato>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/27/2018 05:00 AM, Wolfram Sang wrote:
>>> -	rwdt_write(priv, 0, RWTCSRB);
>>> -	rwdt_write(priv, priv->cks, RWTCSRA);
>>
>> Isn't this done implicitly with the above already ?
>> After all, priv->cks won't have RWTCSRA_TME set.
> 
> Yes. The request came from a group doing some (safety?) audit who didn't
> like the implicit handling which might change if the code in probe()
> might change somewhen. And the datasheet explicitly says to disable the
> timer first before doing anything with the clock dividers. Given that, I
> can agree to this change, too.
> 

Defensive code is fine, bit that is a bit too defensive. We might as well
start checking value ranges in the drivers' set_timeout functions just in case
the core gets it wrong. Just add a note to the probe function where cks is
initialized that RWTCSRA_TME must not be set, and that RWTCSRA_TME must be
cleared before changing the divider.

Guenter
