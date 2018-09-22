Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41591 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392142AbeIVGNh (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 22 Sep 2018 02:13:37 -0400
Subject: Re: [PATCH] watchdog/hpwdt: Disable PreTimeout when Timeout is
 smaller
To: Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180921205039.11466-1-jerry.hoemann@hpe.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <32cd1d39-f8d2-8b40-e025-4e3cda27c2c5@roeck-us.net>
Date: Fri, 21 Sep 2018 17:22:16 -0700
MIME-Version: 1.0
In-Reply-To: <20180921205039.11466-1-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/21/2018 01:50 PM, Jerry Hoemann wrote:
> During module install, disable pretimeout if the requested timeout
> value is not greater than the minimal pretimeout value that is
> supported by hardware.
> 
> This makes the module load handling of pretimeout consistent
> with the ioctl handling of pretimeout.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
