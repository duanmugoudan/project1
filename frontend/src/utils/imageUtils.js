// 图片URL处理工具
import request from './request'

/**
 * 将相对路径转换为完整的图片访问URL
 * @param {string} relativePath - 相对路径，如 "/static/uploads/image.jpg"
 * @returns {string} - 完整的图片URL
 */
export function getImageUrl(relativePath) {
  if (!relativePath) {
    return ''
  }
  
  // 如果已经是完整URL，直接返回
  if (relativePath.startsWith('http://') || relativePath.startsWith('https://')) {
    return relativePath
  }
  
  // 获取后端基础URL
  const baseURL = process.env.VUE_APP_BASEURL 
  
  // 拼接完整URL
  return `${baseURL}${relativePath}`
}

/**
 * 批量处理图片URL数组
 * @param {Array} items - 包含图片路径的对象数组
 * @param {string} imageField - 图片字段名，默认为 'pic'
 * @returns {Array} - 处理后的数组
 */
export function processImageUrls(items, imageField = 'pic') {
  if (!Array.isArray(items)) {
    return items
  }
  
  return items.map(item => {
    if (item && item[imageField]) {
      return {
        ...item,
        [imageField]: getImageUrl(item[imageField])
      }
    }
    return item
  })
}
