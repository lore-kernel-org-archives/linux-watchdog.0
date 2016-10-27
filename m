Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:60232 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935350AbcJ0POP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 27 Oct 2016 11:14:15 -0400
Date: Thu, 27 Oct 2016 17:01:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zahari Doychev <zahari.doychev@linux.com>
Cc: linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        wsa@the-dreams.de, linus.walleij@linaro.org, wim@iguana.be,
        linux@roeck-us.net, linux-i2c@vger.kernel.org,
        linux-gpio@vger.kernel.org, gnurou@gmail.com,
        linux-watchdog@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] add support for DMO embedded controller
Message-ID: <20161027150151.GA19519@kroah.com>
References: <cover.42dd8126f6e33b5130d9afa4596d88a106c54188.1477564996.git-series.zahari.doychev@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.42dd8126f6e33b5130d9afa4596d88a106c54188.1477564996.git-series.zahari.doychev@linux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Oct 27, 2016 at 12:47:11PM +0200, Zahari Doychev wrote:
> This patch series adds support for the Data Modul Embedded Controller(dmec)
> which is implemented within an on board FPGA found on Data Modul embedded
> CPU modules.
> 
> The dmec is connected to the host through the LPC bus and its registers are
> mapped into the host I/O space. The controller supports two addressing modes:
> linear and indexed.
> 
> The driver adds support for the following functionality:
> 
> - i2c
> - gpio
> - watchdog
> - running time meter (rtm)

Why do you want these in staging?  I need a TODO file listing what needs
to be done to the code to get it out of staging, and for someone to
agree to work toward that goal.

Please resend the series with that information.

thanks,

greg k-h
