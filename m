Return-path: <robherring2@gmail.com>
Date: Wed, 9 Nov 2016 12:24:44 -0600
From: Rob Herring <robh@kernel.org>
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>,
	LINUX-INPUT <linux-input@vger.kernel.org>,
	LINUX-KERNEL <linux-kernel@vger.kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eduardo Valentin <edubezval@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	LINUX-PM <linux-pm@vger.kernel.org>,
	LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Support Opensource <support.opensource@diasemi.com>,
	Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V3 4/9] Documentation: devicetree: mfd: da9062/61 MFD
 binding
Message-ID: <20161109182444.tqo2lv3u7p4rk5io@rob-hp-laptop>
References: <cover.1477929725.git.stwiss.opensource@diasemi.com>
 <502d13b97c67023f2193abfa235e8884eb0ea02f.1477929725.git.stwiss.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <502d13b97c67023f2193abfa235e8884eb0ea02f.1477929725.git.stwiss.opensource@diasemi.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Oct 31, 2016 at 04:02:03PM +0000, Steve Twiss wrote:
> From: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> Extend existing DA9062 binding information to include the DA9061 PMIC for
> MFD core and regulators.
> 
> Add a da9062-onkey link to the existing onkey binding file.
> 
> Add a da9062-thermal link to the new temperature monitoring binding file.
> 
> Delete the da9062-watchdog section and replace it with a link to the new
> DA9061/62 binding information file.
> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

Acked-by: Rob Herring <robh@kernel.org>
