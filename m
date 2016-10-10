Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36540 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752354AbcJJNjr (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 10 Oct 2016 09:39:47 -0400
Date: Mon, 10 Oct 2016 08:39:44 -0500
From: Rob Herring <robh@kernel.org>
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        LINUX-INPUT <linux-input@vger.kernel.org>,
        LINUX-PM <linux-pm@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V1 07/10] Documentation: dt: watchdog: da9062/61 Watchdog
 timer binding
Message-ID: <20161010133944.GA20058@rob-hp-laptop>
References: <cover.1475743411.git.stwiss.opensource@diasemi.com>
 <6e2e5600560d0bad024e845221d5e04b93d8cd68.1475743411.git.stwiss.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e2e5600560d0bad024e845221d5e04b93d8cd68.1475743411.git.stwiss.opensource@diasemi.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Oct 06, 2016 at 09:43:31AM +0100, Steve Twiss wrote:
> From: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> Add binding information for DA9062 and DA9061 watchdog.
> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> ---
> This patch applies against linux-next and v4.8
> 
> Hi,
> 
> This patch depends on the acceptance of DA9061 watchdog driver:
>   [PATCH V1 4/10] watchdog: da9061: watchdog driver
> 
> Regards,
> Steve Twiss, Dialog Semiconductor Ltd.
> 
> 
>  Documentation/devicetree/bindings/watchdog/da9062-wdt.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/da9062-wdt.txt

Acked-by: Rob Herring <robh@kernel.org>
