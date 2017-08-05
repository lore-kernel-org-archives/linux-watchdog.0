Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751230AbdHEBwG (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 4 Aug 2017 21:52:06 -0400
Date: Sat, 5 Aug 2017 09:50:55 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@savoirfairelinux.com, robh@kernel.org, linux@roeck-us.net,
        linus.walleij@linaro.org, fabio.estevam@nxp.com,
        mark@embeddedarm.com, kris@embeddedarm.com
Subject: Re: [PATCH v5 0/8] Add board support for TS-4600
Message-ID: <20170805015053.GM31819@dragon>
References: <20170714203218.14409-1-sebastien.bourdelin@savoirfairelinux.com>
 <20170803012652.GB31819@dragon>
 <d40e5ff1-2741-af5c-9dee-b24cd5780aae@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d40e5ff1-2741-af5c-9dee-b24cd5780aae@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Aug 03, 2017 at 03:32:36PM -0400, Sebastien Bourdelin wrote:
> Hi Shawn,
> 
> Thanks i understand, however if it's ok, i would like to process in the
> same time with the TS4600 board bindings and initial dts without the
> part related to the nbus and watchdog.
> There is no dependencies here and we can accellerate the process.

Okay.  I just put a few comments on the initial dts patch.  I can pick
it up after the comments get addressed.

Shawn
