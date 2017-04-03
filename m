Return-path: <robherring2@gmail.com>
Date: Mon, 3 Apr 2017 11:10:09 -0500
From: Rob Herring <robh@kernel.org>
To: Yannick Fertre <yannick.fertre@st.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	Alexandre TORGUE <alexandre.torgue@st.com>,
	Benjamin Gaignard <benjamin.gaignard@st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Philippe Cornu <philippe.cornu@st.com>,
	Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/5] dt-bindings: watchdog: Document STM32 IWDG
 bindings
Message-ID: <20170403161009.zkddbn4elfakbqnq@rob-hp-laptop>
References: <1490886926-20585-1-git-send-email-yannick.fertre@st.com>
 <1490886926-20585-2-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490886926-20585-2-git-send-email-yannick.fertre@st.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, Mar 30, 2017 at 05:15:22PM +0200, Yannick Fertre wrote:
> This adds documentation of device tree bindings for the STM32 IWDG
> (Independent WatchDoG).
> 
> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> 
> Author:    Yannick Fertre <yannick.fertre@st.com>

This shouldn't be here.

> ---
>  .../devicetree/bindings/watchdog/st,stm32-iwdg.txt        | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt

Otherwise,

Acked-by: Rob Herring <robh@kernel.org> 
