Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36443 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935063AbcJ0Pye (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 27 Oct 2016 11:54:34 -0400
From: Zahari Doychev <zahari.doychev@linux.com>
Date: Thu, 27 Oct 2016 17:54:29 +0200
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Zahari Doychev <zahari.doychev@linux.com>,
        linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        wsa@the-dreams.de, linus.walleij@linaro.org, wim@iguana.be,
        linux@roeck-us.net, linux-i2c@vger.kernel.org,
        linux-gpio@vger.kernel.org, gnurou@gmail.com,
        linux-watchdog@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] add support for DMO embedded controller
Message-ID: <20161027155429.GD3701@mail>
References: <cover.42dd8126f6e33b5130d9afa4596d88a106c54188.1477564996.git-series.zahari.doychev@linux.com>
 <20161027150151.GA19519@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161027150151.GA19519@kroah.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Oct 27, 2016 at 05:01:51PM +0200, Greg KH wrote:
> On Thu, Oct 27, 2016 at 12:47:11PM +0200, Zahari Doychev wrote:
> > This patch series adds support for the Data Modul Embedded Controller(dmec)
> > which is implemented within an on board FPGA found on Data Modul embedded
> > CPU modules.
> > 
> > The dmec is connected to the host through the LPC bus and its registers are
> > mapped into the host I/O space. The controller supports two addressing modes:
> > linear and indexed.
> > 
> > The driver adds support for the following functionality:
> > 
> > - i2c
> > - gpio
> > - watchdog
> > - running time meter (rtm)
> 
> Why do you want these in staging?  I need a TODO file listing what needs
> to be done to the code to get it out of staging, and for someone to
> agree to work toward that goal.

Actually there is no reason to have them in staging. I was not sure what was
the right way to go. I just wanted to get some feedback. The drivers have been
through a lot of testing so next time I will resend the patches putting
each driver in its subsystem.

Regards Zahari

> 
> Please resend the series with that information.
> 
> thanks,
> 
> greg k-h
