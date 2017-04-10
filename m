Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35298 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752395AbdDJSZv (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 10 Apr 2017 14:25:51 -0400
Date: Mon, 10 Apr 2017 13:25:49 -0500
From: Rob Herring <robh@kernel.org>
To: Yannick Fertre <yannick.fertre@st.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philippe Cornu <philippe.cornu@st.com>,
        Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/5] dt-bindings: watchdog: Document STM32 IWDG
 bindings
Message-ID: <20170410182549.yqkmolezpjj6eubg@rob-hp-laptop>
References: <1491481168-22213-1-git-send-email-yannick.fertre@st.com>
 <1491481168-22213-2-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491481168-22213-2-git-send-email-yannick.fertre@st.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Apr 06, 2017 at 02:19:24PM +0200, Yannick Fertre wrote:
> This adds documentation of device tree bindings for the STM32 IWDG
> (Independent WatchDoG).
> 
> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> ---
>  .../devicetree/bindings/watchdog/st,stm32-iwdg.txt    | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt

Acked-by: Rob Herring <robh@kernel.org>
