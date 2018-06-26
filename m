Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33082 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933655AbeFZUjm (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 26 Jun 2018 16:39:42 -0400
Date: Tue, 26 Jun 2018 14:39:39 -0600
From: Rob Herring <robh@kernel.org>
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V5 1/5] dt-bindings: watchdog: add stm32mp1 support
Message-ID: <20180626203939.GA17242@rob-hp-laptop>
References: <1529941383-8653-1-git-send-email-ludovic.Barre@st.com>
 <1529941383-8653-2-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529941383-8653-2-git-send-email-ludovic.Barre@st.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jun 25, 2018 at 05:42:59PM +0200, Ludovic Barre wrote:
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
