Return-path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <9fcc2a2cc8273f461baa13c6c9992f3ca56b508a.1439915117.git.panand@redhat.com>
References: <9fcc2a2cc8273f461baa13c6c9992f3ca56b508a.1439915117.git.panand@redhat.com>
Date: Wed, 26 Aug 2015 13:38:19 +0200
Message-ID: <CACRpkdbT0Ew_LXys++EDykM-gp08dxKQ4HYp0CfAmk7EoCET9A@mail.gmail.com>
Subject: Re: [PATCH V2] Watchdog: Fix parent of watchdog_devices
From: Linus Walleij <linus.walleij@linaro.org>
To: Pratyush Anand <panand@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	Alexandre Courbot <gnurou@gmail.com>, Andreas Werner <andreas.werner@men.de>, Barry Song <baohua@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>, Johannes Thumshirn <morbidrsa@gmail.com>,
	"open list:ARM/STI ARCHITECTURE" <kernel@stlinux.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Kukjin Kim <kgene@kernel.org>, Lee Jones <lee@kernel.org>,
	"moderated list:ARM/U300 MACHINE SUPPORT" <linux-arm-kernel@lists.infradead.org>,
	"open list:INTEL MANAGEMENT ENGINE (mei)" <linux-kernel@vger.kernel.org>,
	"moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" <linux-samsung-soc@vger.kernel.org>,
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>, Maxime Coquelin <maxime.coquelin@st.com>,
	"open list:WOLFSON MICROELECTRONICS DRIVERS" <patches@opensource.wolfsonmicro.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>,
	Support Opensource <support.opensource@diasemi.com>, Thierry Reding <thierry.reding@gmail.com>,
	Tomas Winkler <tomas.winkler@intel.com>, Wim Van Sebroeck <wim@iguana.be>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Aug 18, 2015 at 6:34 PM, Pratyush Anand <panand@redhat.com> wrote:

> /sys/class/watchdog/watchdogn/device/modalias can help to identify the
> driver/module for a given watchdog node. However, many wdt devices does not set
> its parent and so, we do not see an entry for device in sysfs for such devices.
>
> This patch fixes parent of watchdog_device so that
> /sys/class/watchdog/watchdogn/device is populated.
>
> Exceptions: booke, diag288, mpc8xxx, octeon, softdog and w83627hf -- They do not
> have any parent. Not sure, how we can we identify driver for these devices.
>
> Signed-off-by: Pratyush Anand <panand@redhat.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
