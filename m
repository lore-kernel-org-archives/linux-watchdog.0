Return-path: <robherring2@gmail.com>
Date: Fri, 23 Sep 2016 10:08:44 -0500
From: Rob Herring <robh@kernel.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@stlinux.com, patrice.chotard@st.com,
	devicetree@vger.kernel.org, lee.jones@linaro.org, wim@iguana.be,
	linux@roeck-us.net, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 10/19] watchdog: bindings: Remove obsolete platforms from
 dt doc.
Message-ID: <20160923150844.GE9176@rob-hp-laptop>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
 <1473859677-9231-11-git-send-email-peter.griffin@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1473859677-9231-11-git-send-email-peter.griffin@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Sep 14, 2016 at 02:27:48PM +0100, Peter Griffin wrote:
> STiH415/6 SoC support is being removed from the kernel
> so update the dt bding document to reflect this.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Cc: <wim@iguana.be>
> Cc: <linux@roeck-us.net>
> Cc: <robh+dt@kernel.org>
> Cc: <linux-watchdog@vger.kernel.org>
> ---
>  Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
