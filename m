Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35067 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754600AbeFYPvd (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 25 Jun 2018 11:51:33 -0400
Date: Mon, 25 Jun 2018 09:51:30 -0600
From: Rob Herring <robh@kernel.org>
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V4 1/4] dt-bindings: watchdog: add stm32mp1 support
Message-ID: <20180625155130.GA25449@rob-hp-laptop>
References: <1529571737-3552-1-git-send-email-ludovic.Barre@st.com>
 <1529571737-3552-2-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529571737-3552-2-git-send-email-ludovic.Barre@st.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Jun 21, 2018 at 11:02:14AM +0200, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch adds support of stm32mp1.
> stm32mp1 requires 2 clocks lsi and pclk.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  .../devicetree/bindings/watchdog/st,stm32-iwdg.txt          | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
