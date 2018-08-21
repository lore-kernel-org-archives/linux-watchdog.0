Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42815 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbeHURW5 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 21 Aug 2018 13:22:57 -0400
Date: Tue, 21 Aug 2018 07:02:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com
Subject: Re: [PATCH] watchdog: hpwdt: Update Driver Documentation.
Message-ID: <20180821140239.GD17160@roeck-us.net>
References: <20180820193123.23976-1-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820193123.23976-1-jerry.hoemann@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Aug 20, 2018 at 01:31:23PM -0600, Jerry Hoemann wrote:
> Remove references to deprecated features like NMI sourcing
> and obsoleted module parameters.
> 
> Add details concerning new module parameter pretimeout and tips
> to programming it.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
