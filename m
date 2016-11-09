Return-path: <robherring2@gmail.com>
Date: Wed, 9 Nov 2016 12:24:43 -0600
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
Subject: Re: [PATCH V3 2/9] Documentation: devicetree: watchdog: da9062/61
 watchdog timer binding
Message-ID: <20161109182443.5cb2jdfopdmo6cy7@rob-hp-laptop>
References: <cover.1477929725.git.stwiss.opensource@diasemi.com>
 <35578f27515c2abc1780823829ebab467543548c.1477929725.git.stwiss.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35578f27515c2abc1780823829ebab467543548c.1477929725.git.stwiss.opensource@diasemi.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Oct 31, 2016 at 04:02:03PM +0000, Steve Twiss wrote:
> From: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> Add binding information for DA9062 and DA9061 watchdog.
> 
> Example bindings for both DA9062 and DA9061 devices are added. For
> the DA9061 device, a fallback compatible line is added as a valid
> combination of compatible strings.
> 
> The original binding for DA9062 (only) used to reside inside the
> Documentation/devicetree/bindings/mfd/da9062.txt MFD document.
> The da9062-watchdog section was deleted in that file and replaced
> with a link to the new DA9061/62 binding information stored in this
> patch.
> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

Acked-by: Rob Herring <robh@kernel.org>
