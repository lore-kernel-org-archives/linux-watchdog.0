Return-path: <hanjun.guo@linaro.org>
Message-ID: <555F3706.2070502@linaro.org>
Date: Fri, 22 May 2015 22:02:46 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com,
 linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
CC: tekkamanninja@gmail.com, graeme.gregory@linaro.org,
 al.stone@linaro.org, timur@codeaurora.org, ashwin.chaugule@linaro.org,
 arnd@arndb.de, linux@roeck-us.net, vgandhi@codeaurora.org,
 wim@iguana.be, jcm@redhat.com, leo.duran@amd.com, corbet@lwn.net,
 mark.rutland@arm.com
Subject: Re: [PATCH v2 1/7] clocksource: export "arch_timer_get_rate" for
 the other drivers
References: <=fu.wei@linaro.org> <1432197156-16947-1-git-send-email-fu.wei@linaro.org> <1432197156-16947-2-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1432197156-16947-2-git-send-email-fu.wei@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

On 2015年05月21日 16:32, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> Some devices get clock from system counter, like SBSA watchdog
> driver. They may need to get system counter rate.

and please add a comment that SBSA watchdog is a kernel module,
then it would explicit that why EXPORT_SYMBOL_GPL is needed.

>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>

Other than that,

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

> ---
>   drivers/clocksource/arm_arch_timer.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 0aa135d..4327bf9 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -410,6 +410,7 @@ u32 arch_timer_get_rate(void)
>   {
>   	return arch_timer_rate;
>   }
> +EXPORT_SYMBOL_GPL(arch_timer_get_rate);
>
>   static u64 arch_counter_get_cntvct_mem(void)
>   {
>
