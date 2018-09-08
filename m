Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36981 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbeIHOW4 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 8 Sep 2018 10:22:56 -0400
MIME-Version: 1.0
References: <1536325173-16617-1-git-send-email-p.paillet@st.com> <1536325173-16617-5-git-send-email-p.paillet@st.com>
In-Reply-To: <1536325173-16617-5-git-send-email-p.paillet@st.com>
From: Antonio Borneo <borneo.antonio@gmail.com>
Date: Sat, 8 Sep 2018 11:37:29 +0200
Message-ID: <CAAj6DX2tnT5wjmy9nfRx7ut62_6rsQ00RNjaXX3WxMsB+mSHYw@mail.gmail.com>
Subject: Re: [PATCH V2 4/8] regulator: stpmic1: add stpmic1 regulator driver
To: p.paillet@st.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, lee.jones@linaro.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, wim@linux-watchdog.org,
        linux@roeck-us.net, linux-input <linux-input@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, benjamin.gaignard@linaro.org,
        eballetbo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Sep 7, 2018 at 3:15 PM Pascal PAILLET-LME <p.paillet@st.com> wrote:
>
> From: pascal paillet <p.paillet@st.com>
>
> The stpmic1 PMIC embeds several regulators and witches with
> different capabilities.

While fixing Kconfig, as Mark suggest, would you mind to fix also the
typo s/witches/switches/ in the commit message?

Antonio
